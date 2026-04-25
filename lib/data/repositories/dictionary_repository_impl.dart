import 'dart:convert';
import 'dart:io';

import 'package:paste_tool/domain/entities/dictionary_entry.dart';
import 'package:paste_tool/domain/repositories/dictionary_repository.dart';

/// Реализация словаря через HTTP API dabkrs backend.
class ApiDictionaryRepository implements DictionaryRepository {
  final String baseUrl;
  final HttpClient client;

  ApiDictionaryRepository({
    this.baseUrl = 'https://translatechinese.online',
    HttpClient? client,
  }) : client = client ?? HttpClient();

  @override
  Future<List<DictionaryEntry>> search(String query) async {
    if (query.trim().isEmpty) return [];

    try {
      final uri = Uri.parse(
        '$baseUrl/api/entries?word=${Uri.encodeComponent(query.trim())}',
      );
      final request = await client.getUrl(uri);
      final response = await request.close();

      if (response.statusCode != 200) {
        throw HttpException(
          'API вернул ${response.statusCode}',
          uri: uri,
        );
      }

      final body = await response.transform(utf8.decoder).join();
      final json = jsonDecode(body) as Map<String, dynamic>;
      final data = json['data'] as List? ?? [];

      return data.map((e) {
        final meanings = (e['meanings'] as List?) ?? [];
        return DictionaryEntry(
          id: e['id'].toString(),
          headword: e['hanzi'] ?? '',
          pinyin: e['pinyin'] ?? '',
          translations: meanings
              .map((m) => (m as Map)['text']?.toString() ?? '')
              .where((t) => t.isNotEmpty)
              .toList(),
        );
      }).toList();
    } on SocketException catch (e) {
      throw Exception('Сервер недоступен: ${e.message}');
    } on HttpException catch (e) {
      throw Exception('Ошибка API: ${e.message}');
    } on FormatException {
      throw Exception('Неверный формат ответа от сервера');
    }
  }

  void dispose() {
    client.close();
  }
}
