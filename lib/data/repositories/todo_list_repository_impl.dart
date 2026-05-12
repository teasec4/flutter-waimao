import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/todo_list_collection.dart';
import 'package:paste_tool/domain/entities/todo_list.dart';
import 'package:paste_tool/domain/repositories/todo_list_repository.dart';

class TodoListRepositoryImpl implements TodoListRepository {
  final Isar isar;

  TodoListRepositoryImpl({required this.isar});

  @override
  Future<List<TodoList>> getLists() async {
    final collections = await isar.todoListCollections.where().sortByCreatedAt().findAll();
    return collections
        .map((c) => TodoList(
              id: c.uuid,
              name: c.name,
              createdAt: c.createdAt,
            ))
        .toList();
  }

  @override
  Future<void> addList(TodoList list) async {
    final collection = TodoListCollection()
      ..uuid = list.id
      ..name = list.name
      ..createdAt = list.createdAt;
    await isar.writeTxn(() => isar.todoListCollections.put(collection));
  }

  @override
  Future<void> updateList(TodoList list) async {
    final existing = await isar.todoListCollections.filter().uuidEqualTo(list.id).findFirst();
    if (existing == null) return;
    await isar.writeTxn(() async {
      existing.name = list.name;
      await isar.todoListCollections.put(existing);
    });
  }

  @override
  Future<void> deleteList(String id) async {
    final existing = await isar.todoListCollections.filter().uuidEqualTo(id).findFirst();
    if (existing == null) return;
    await isar.writeTxn(() => isar.todoListCollections.delete(existing.id));
  }

  @override
  Future<void> reorderLists(List<TodoList> lists) async {
    final all = await isar.todoListCollections.where().findAll();
    await isar.writeTxn(() async {
      for (var i = 0; i < lists.length; i++) {
        final match = all.where((c) => c.uuid == lists[i].id).firstOrNull;
        if (match != null) {
          match.name = lists[i].name;
          await isar.todoListCollections.put(match);
        }
      }
    });
  }
}
