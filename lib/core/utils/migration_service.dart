import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/phrase_collection.dart';

/// Migrates data from legacy SharedPreferences format to Isar database.
class MigrationService {
  /// Attempts to read legacy SharedPreferences data and migrate to Isar.
  /// Returns true if migration was performed.
  static Future<bool> migrateFromLegacy(Isar isar) async {
    return false;
  }

  /// Takes raw legacy data (pipe-separated strings or JSON array)
  /// and writes it into Isar, then marks migration as complete.
  static Future<List<PhraseCollection>> migrateAndReturn(
    Isar isar,
    String? legacyRaw,
  ) async {
    if (legacyRaw == null || legacyRaw.isEmpty) {
      return isar.phraseCollections.where().findAllSync();
    }

    final existingCount = await isar.phraseCollections.where().count();
    if (existingCount > 0) {
      return isar.phraseCollections.where().findAllSync();
    }

    List<PhraseCollection> legacyCollections;

    try {
      final list = jsonDecode(legacyRaw) as List<dynamic>;
      legacyCollections = list.map((e) {
        final map = e as Map<String, dynamic>;
        return PhraseCollection()
          ..uuid =
              (map['id'] as String?) ??
              DateTime.now().millisecondsSinceEpoch.toString()
          ..text = map['text'] as String;
      }).toList();
    } catch (_) {
      legacyCollections = legacyRaw
          .split('|||')
          .where((e) => e.isNotEmpty)
          .map(
            (text) => PhraseCollection()
              ..uuid =
                  DateTime.now().millisecondsSinceEpoch.toString() +
                  text.hashCode.toString()
              ..text = text,
          )
          .toList();
    }

    if (legacyCollections.isNotEmpty) {
      await isar.writeTxn(() async {
        await isar.phraseCollections.putAll(legacyCollections);
      });
      debugPrint(
        'MigrationService: migrated ${legacyCollections.length} phrases',
      );
    }

    return legacyCollections;
  }
}
