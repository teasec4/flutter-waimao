import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/todo_item_collection.dart';
import 'package:paste_tool/domain/entities/todo_item.dart';
import 'package:paste_tool/domain/repositories/todo_item_repository.dart';

class TodoItemRepositoryImpl implements TodoItemRepository {
  final Isar isar;

  TodoItemRepositoryImpl({required this.isar});

  @override
  Future<List<TodoItem>> getItems(String listId) async {
    final collections = await isar.todoItemCollections
        .filter()
        .listIdEqualTo(listId)
        .sortBySortOrder()
        .findAll();
    return collections
        .map((c) => TodoItem(
              id: c.uuid,
              text: c.text,
              isDone: c.isDone,
              listId: c.listId,
              sortOrder: c.sortOrder,
              createdAt: c.createdAt,
            ))
        .toList();
  }

  @override
  Future<void> addItem(TodoItem item) async {
    final collection = TodoItemCollection()
      ..uuid = item.id
      ..text = item.text
      ..isDone = item.isDone
      ..listId = item.listId
      ..sortOrder = item.sortOrder
      ..createdAt = item.createdAt;
    await isar.writeTxn(() => isar.todoItemCollections.put(collection));
  }

  @override
  Future<void> updateItem(TodoItem item) async {
    final existing = await isar.todoItemCollections.filter().uuidEqualTo(item.id).findFirst();
    if (existing == null) return;
    await isar.writeTxn(() async {
      existing.text = item.text;
      existing.isDone = item.isDone;
      existing.sortOrder = item.sortOrder;
      await isar.todoItemCollections.put(existing);
    });
  }

  @override
  Future<void> deleteItem(String id) async {
    final existing = await isar.todoItemCollections.filter().uuidEqualTo(id).findFirst();
    if (existing == null) return;
    await isar.writeTxn(() => isar.todoItemCollections.delete(existing.id));
  }

  @override
  Future<void> reorderItems(List<TodoItem> items) async {
    final all = await isar.todoItemCollections.filter().listIdEqualTo(items.first.listId).findAll();
    await isar.writeTxn(() async {
      for (var i = 0; i < items.length; i++) {
        final match = all.where((c) => c.uuid == items[i].id).firstOrNull;
        if (match != null) {
          match.sortOrder = i;
          await isar.todoItemCollections.put(match);
        }
      }
    });
  }
}
