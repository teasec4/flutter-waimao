import 'dart:convert';
import 'dart:io';

import 'package:paste_tool/domain/entities/dictionary_entry.dart';
import 'package:paste_tool/domain/repositories/dictionary_repository.dart';

/// Реализация словаря через HTTP API dabkrs backend.
///
/// TODO: заменить baseUrl на реальный адрес сервера.
class ApiDictionaryRepository implements DictionaryRepository {
  final String baseUrl;
  final HttpClient client;

  ApiDictionaryRepository({
    this.baseUrl = 'http://localhost:8080',
    HttpClient? client,
  }) : client = client ?? HttpClient();

  @override
  Future<List<DictionaryEntry>> search(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final uri = Uri.parse('$baseUrl/api/dictionary/search?q=${Uri.encodeComponent(query)}');
      final request = await client.getUrl(uri);
      final response = await request.close();

      if (response.statusCode != 200) {
        return [];
      }

      final body = await response.transform(utf8.decoder).join();
      final json = jsonDecode(body) as List;
      return json.map((e) => DictionaryEntry(
        id: e['id'].toString(),
        headword: e['headword'] ?? '',
        pinyin: e['pinyin'] ?? '',
        translations: (e['translations'] as List?)?.cast<String>() ?? [],
      )).toList();
    } catch (_) {
      return [];
    }
  }

  void dispose() {
    client.close();
  }
}
