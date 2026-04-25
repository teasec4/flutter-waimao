import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/presentation/providers/dictionary_provider.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final _searchCtrl = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _searchCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _search() {
    final query = _searchCtrl.text.trim();
    if (query.isNotEmpty) {
      context.read<DictionaryProvider>().search(query);
      _focusNode.unfocus();
    }
  }

  void _clear() {
    _searchCtrl.clear();
    context.read<DictionaryProvider>().clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          child: TextField(
            controller: _searchCtrl,
            focusNode: _focusNode,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Введите китайское слово…',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_searchCtrl.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.search),
                      tooltip: 'Поиск',
                      onPressed: _search,
                    ),
                  if (_searchCtrl.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      tooltip: 'Очистить',
                      onPressed: _clear,
                    ),
                ],
              ),
              border: const OutlineInputBorder(),
            ),
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => _search(),
          ),
        ),
        Expanded(
          child: Consumer<DictionaryProvider>(
            builder: (context, provider, _) {
              final state = provider.state;

              switch (state.status) {
                case DictionaryStatus.loading:
                  return const Center(child: CircularProgressIndicator());

                case DictionaryStatus.error:
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.cloud_off, size: 48, color: Colors.grey[400]),
                          const SizedBox(height: 12),
                          Text(
                            state.errorMessage!,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 16),
                          FilledButton.icon(
                            icon: const Icon(Icons.refresh),
                            label: const Text('Повторить'),
                            onPressed: _search,
                          ),
                        ],
                      ),
                    ),
                  );

                case DictionaryStatus.success:
                  if (state.results.isNotEmpty) {
                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: state.results.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (_, i) {
                        final entry = state.results[i];
                        return ListTile(
                          title: Text(
                            entry.headword,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (entry.pinyin.isNotEmpty)
                                Text(
                                  entry.pinyin,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              const SizedBox(height: 4),
                              ...entry.translations.map(
                                (t) => Text('• $t'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return _buildEmptyFound();

                case DictionaryStatus.initial:
                  return _buildWelcome();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWelcome() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.menu_book, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            'Китайско-русский словарь',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Начните вводить слово для поиска',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyFound() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 12),
          Text(
            'Ничего не найдено',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
