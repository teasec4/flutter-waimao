import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:paste_tool/presentation/providers/todo_provider.dart';
import 'package:paste_tool/presentation/routes/todo/widgets/lists_view.dart';
import 'package:paste_tool/presentation/routes/todo/widgets/items_view.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hasActiveList = context.watch<TodoProvider>().activeList != null;

    return hasActiveList ? const ItemsView() : const ListsView();
  }
}
