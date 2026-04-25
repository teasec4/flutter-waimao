import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:paste_tool/domain/entities/dictionary_entry.dart';
import 'package:paste_tool/domain/repositories/dictionary_repository.dart';

/// Репозиторий словаря на основе SQLite.
///
/// При инициализации копирует БД из исходной директории dabkrs (если её нет
/// в директории документов приложения). Поиск повторяет логику dabkrs:
///   - hanzi → точное совпадение по headword (с загрузкой переводов);
///   - pinyin → нормализация (удаление тонов, lowercase) + LIKE с ранжированием;
///   - meaning → JOIN с meanings через GLOB + FTS5 fallback.
/// Избранное хранится отдельным JSON-файлом (не модифицируем исходную БД).
class SqliteDictionaryRepository implements DictionaryRepository {
  Database? _db;
  Set<int> _favoriteIds = {};
  String? _favoritesPath;

  /// Путь к исходной БД dabkrs на машине разработчика.
  static const String sourceDbPath =
      '/Users/yg_kovalev/development/dabkrs/backend/data/dictionary.db';

  /// Инициализация: копирует БД при необходимости и открывает её.
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final destPath = '${dir.path}/dictionary.db';
    _favoritesPath = '${dir.path}/dictionary_favorites.json';

    // Создаём символическую ссылку на исходную БД (не копируем 835MB)
    final entityType = FileSystemEntity.typeSync(destPath, followLinks: false);
    if (entityType == FileSystemEntityType.notFound) {
      final source = File(sourceDbPath);
      if (source.existsSync()) {
        Link(destPath).createSync(sourceDbPath);
      } else {
        throw Exception(
          'Исходная БД не найдена: $sourceDbPath\n'
          'Скопируйте dictionary.db в $destPath',
        );
      }
    }

    // Загружаем избранное
    _favoriteIds = _loadFavorites();

    // Открываем БД
    sqfliteFfiInit();
    _db = await databaseFactoryFfi.openDatabase(destPath);
  }

  // ===== ЗАГРУЗКА ИЗБРАННОГО =====

  Set<int> _loadFavorites() {
    if (_favoritesPath == null) return {};
    final file = File(_favoritesPath!);
    if (!file.existsSync()) return {};
    try {
      final list = jsonDecode(file.readAsStringSync()) as List;
      return list.map((e) => e as int).toSet();
    } catch (_) {
      return {};
    }
  }

  void _saveFavorites() {
    if (_favoritesPath == null) return;
    try {
      File(_favoritesPath!)
          .writeAsStringSync(jsonEncode(_favoriteIds.toList()));
    } catch (_) {
      // игнорируем ошибки записи
    }
  }

  // ===== ДЕТЕКЦИЯ ТИПА ЗАПРОСА =====

  _QueryType _detectQueryType(String query) {
    query = query.trim();
    if (query.isEmpty) return _QueryType.unknown;

    for (final rune in query.runes) {
      final ch = String.fromCharCode(rune);
      if (_isHanChar(ch)) return _QueryType.hanzi;
    }

    if (query.contains(RegExp(r'[a-zA-Z]'))) return _QueryType.pinyin;

    return _QueryType.meaning;
  }

  bool _isHanChar(String ch) {
    final code = ch.codeUnitAt(0);
    return (code >= 0x4E00 && code <= 0x9FFF) ||
        (code >= 0x3400 && code <= 0x4DBF) ||
        (code >= 0xF900 && code <= 0xFAFF) ||
        (code >= 0x2F800 && code <= 0x2FA1F);
  }

  // ===== НОРМАЛИЗАЦИЯ ПИНЬИНЯ =====

  static const _toneMap = {
    'à': 'a', 'á': 'a', 'ǎ': 'a', 'ā': 'a',
    'è': 'e', 'é': 'e', 'ě': 'e', 'ē': 'e',
    'ì': 'i', 'í': 'i', 'ǐ': 'i', 'ī': 'i',
    'ò': 'o', 'ó': 'o', 'ǒ': 'o', 'ō': 'o',
    'ù': 'u', 'ú': 'u', 'ǔ': 'u', 'ū': 'u',
  };

  String _normalizePinyin(String query) {
    query = query.trim().toLowerCase().replaceAll(' ', '');
    return query.split('').map((ch) => _toneMap[ch] ?? ch).join('');
  }

  // ===== ПОИСК (async) =====

  @override
  Future<List<DictionaryEntry>> search(String query) async {
    if (_db == null) return [];
    query = query.trim();
    if (query.isEmpty) return [];

    final type = _detectQueryType(query);

    switch (type) {
      case _QueryType.hanzi:
        return _searchByHanzi(query);
      case _QueryType.pinyin:
        final normalized = _normalizePinyin(query);
        return _searchByPinyin(normalized);
      case _QueryType.meaning:
        return _searchByMeaning(query);
      case _QueryType.unknown:
        return [];
    }
  }

  Future<List<DictionaryEntry>> _searchByHanzi(String query) async {
    final rows = await _db!.rawQuery(
      'SELECT id, headword, pinyin FROM entries WHERE headword = ? LIMIT 50',
      [query],
    );

    final entries = rows
        .map((r) => DictionaryEntry(
              id: r['id'] as int,
              simplified: r['headword'] as String,
              pinyin: (r['pinyin'] as String?) ?? '',
              meanings: [],
              isFavorite: _favoriteIds.contains(r['id'] as int),
            ))
        .toList();

    await _loadMeanings(entries);
    return entries;
  }

  Future<List<DictionaryEntry>> _searchByPinyin(String normalized) async {
    final rows = await _db!.rawQuery(
      '''SELECT id, headword, pinyin
      FROM entries
      WHERE pinyin_normalized = ?
         OR pinyin_normalized LIKE ? || '%'
         OR pinyin_normalized LIKE '%' || ? || '%'
      ORDER BY
        CASE
          WHEN pinyin_normalized = ? THEN 1
          WHEN pinyin_normalized LIKE ? || '%' THEN 2
          ELSE 3
        END,
        LENGTH(headword) ASC
      LIMIT 230''',
      [normalized, normalized, normalized, normalized, normalized],
    );

    final entries = rows
        .map((r) => DictionaryEntry(
              id: r['id'] as int,
              simplified: r['headword'] as String,
              pinyin: (r['pinyin'] as String?) ?? '',
              meanings: [],
              isFavorite: _favoriteIds.contains(r['id'] as int),
            ))
        .toList();

    await _loadMeanings(entries);
    return entries;
  }

  Future<List<DictionaryEntry>> _searchByMeaning(String query) async {
    final rows = await _db!.rawQuery(
      '''SELECT DISTINCT e.id, e.headword, e.pinyin
      FROM entries e
      JOIN meanings m ON e.id = m.entry_id
      WHERE m.text = ? OR m.text GLOB ? OR m.text GLOB ? OR m.text GLOB ?
      LIMIT 20''',
      [query, '$query *', '$query,*', '*,$query'],
    );

    var entries = rows
        .map((r) => DictionaryEntry(
              id: r['id'] as int,
              simplified: r['headword'] as String,
              pinyin: (r['pinyin'] as String?) ?? '',
              meanings: [],
              isFavorite: _favoriteIds.contains(r['id'] as int),
            ))
        .toList();

    // Если GLOB не дал результатов, пробуем FTS5
    if (entries.isEmpty) {
      entries = await _searchByMeaningFts(query);
      if (entries.isNotEmpty) return entries;
    }

    await _loadMeanings(entries);
    return entries;
  }

  /// Загружает переводы для списка записей (batch load как в dabkrs).
  Future<void> _loadMeanings(List<DictionaryEntry> entries) async {
    if (entries.isEmpty) return;

    final ids = entries.map((e) => e.id).toList();
    final placeholders = ids.map((_) => '?').join(',');

    final rows = await _db!.rawQuery(
      '''SELECT entry_id, id, order_num, text
      FROM meanings
      WHERE entry_id IN ($placeholders)
      ORDER BY entry_id, order_num ASC''',
      ids,
    );

    final Map<int, List<DictionaryMeaning>> grouped = {};
    for (final row in rows) {
      final entryId = row['entry_id'] as int;
      grouped.putIfAbsent(entryId, () => []).add(DictionaryMeaning(
            id: row['id'] as int,
            text: row['text'] as String,
            orderNum: (row['order_num'] as int?) ?? 0,
          ));
    }

    for (final entry in entries) {
      entry.meanings.addAll(grouped[entry.id] ?? []);
    }
  }

  /// Поиск через FTS5 — fallback, когда GLOB не дал результатов.
  Future<List<DictionaryEntry>> _searchByMeaningFts(String query) async {
    final safe = query.replaceAll(RegExp(r'["*]'), '');
    if (safe.isEmpty) return [];

    final rows = await _db!.rawQuery(
      '''SELECT DISTINCT e.id, e.headword, e.pinyin
      FROM meanings_fts f
      JOIN entries e ON e.id = f.entry_id
      WHERE meanings_fts MATCH ?
      LIMIT 20''',
      ['"$safe"'],
    );

    final entries = rows
        .map((r) => DictionaryEntry(
              id: r['id'] as int,
              simplified: r['headword'] as String,
              pinyin: (r['pinyin'] as String?) ?? '',
              meanings: [],
              isFavorite: _favoriteIds.contains(r['id'] as int),
            ))
        .toList();

    await _loadMeanings(entries);
    return entries;
  }

  @override
  Future<List<DictionaryEntry>> getAll() async {
    // Не загружаем всё — 3.4 млн записей в БД.
    return [];
  }

  @override
  Future<List<DictionaryEntry>> getFavorites() async {
    if (_favoriteIds.isEmpty || _db == null) return [];

    final ids = _favoriteIds.toList();
    // Загружаем избранное по 50 записей за раз
    final batches = <List<int>>[];
    for (var i = 0; i < ids.length; i += 50) {
      batches.add(ids.sublist(i, i + 50 > ids.length ? ids.length : i + 50));
    }

    final allEntries = <DictionaryEntry>[];
    for (final batch in batches) {
      final placeholders = batch.map((_) => '?').join(',');
      final rows = await _db!.rawQuery(
        'SELECT id, headword, pinyin FROM entries WHERE id IN ($placeholders)',
        batch,
      );

      for (final r in rows) {
        allEntries.add(DictionaryEntry(
          id: r['id'] as int,
          simplified: r['headword'] as String,
          pinyin: (r['pinyin'] as String?) ?? '',
          meanings: [],
          isFavorite: true,
        ));
      }
    }

    await _loadMeanings(allEntries);
    return allEntries;
  }

  @override
  void toggleFavorite(int entryId) {
    if (_favoriteIds.contains(entryId)) {
      _favoriteIds.remove(entryId);
    } else {
      _favoriteIds.add(entryId);
    }
    _saveFavorites();
  }
}

enum _QueryType { unknown, hanzi, pinyin, meaning }
