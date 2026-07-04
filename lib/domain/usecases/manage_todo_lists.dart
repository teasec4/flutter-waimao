import 'package:uuid/uuid.dart';

import '../entities/todo_list.dart';
import '../repositories/todo_list_repository.dart';

const _uuid = Uuid();

class ManageTodoLists {
  final TodoListRepository repository;

  ManageTodoLists(this.repository);

  Future<List<TodoList>> getLists() => repository.getLists();

  Future<void> addList(String name) {
    final list = TodoList(
      id: _uuid.v4(),
      name: name,
      createdAt: DateTime.now(),
    );
    return repository.addList(list);
  }

  Future<void> renameList(String id, String name) async {
    // Load existing list to preserve original creation date
    final lists = await repository.getLists();
    final existing = lists.firstWhere((l) => l.id == id);
    return repository.updateList(
      TodoList(id: id, name: name, createdAt: existing.createdAt),
    );
  }

  Future<void> deleteList(String id) => repository.deleteList(id);
}
