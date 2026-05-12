import 'package:uuid/uuid.dart';

import '../entities/todo_item.dart';
import '../repositories/todo_item_repository.dart';

const _uuid = Uuid();

class ManageTodoItems {
  final TodoItemRepository repository;

  ManageTodoItems(this.repository);

  Future<List<TodoItem>> getItems(String listId) => repository.getItems(listId);

  Future<void> addItem(String text, String listId, {int sortOrder = 0}) {
    final item = TodoItem(
      id: _uuid.v4(),
      text: text,
      listId: listId,
      sortOrder: sortOrder,
      createdAt: DateTime.now(),
    );
    return repository.addItem(item);
  }

  Future<void> toggleDone(String id, TodoItem item) {
    final updated = TodoItem(
      id: item.id,
      text: item.text,
      isDone: !item.isDone,
      listId: item.listId,
      sortOrder: item.sortOrder,
      createdAt: item.createdAt,
    );
    return repository.updateItem(updated);
  }

  Future<void> deleteItem(String id) => repository.deleteItem(id);

  Future<void> reorder(List<TodoItem> items) => repository.reorderItems(items);
}
