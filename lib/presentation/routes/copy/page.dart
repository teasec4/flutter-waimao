import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/presentation/providers/phrase_provider.dart';
import 'package:paste_tool/presentation/routes/copy/widgets/categories_view.dart';
import 'package:paste_tool/presentation/routes/copy/widgets/phrases_view.dart';

class CopyPage extends StatelessWidget {
  const CopyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hasActiveCategory =
        context.watch<PhraseProvider>().activeCategory != null;

    return hasActiveCategory ? const PhrasesView() : const CategoriesView();
  }
}
