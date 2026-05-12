import '../entities/todo_item.dart';

abstract class TodoItemRepository {
  Future<List<TodoItem>> getItems(String listId);
  Future<void> addItem(TodoItem item);
  Future<void> updateItem(TodoItem item);
  Future<void> deleteItem(String id);
  Future<void> reorderItems(List<TodoItem> items);
}
