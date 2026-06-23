import 'package:isar_community/isar.dart';
import 'package:paste_tool/data/collections/todo_item_collection.dart';
import 'package:paste_tool/data/collections/todo_list_collection.dart';
import 'package:paste_tool/domain/entities/todo_list.dart';
import 'package:paste_tool/domain/repositories/todo_list_repository.dart';

class TodoListRepositoryImpl implements TodoListRepository {
  final Isar isar;

  TodoListRepositoryImpl({required this.isar});

  @override
  Future<List<TodoList>> getLists() async {
    final collections = await isar.todoListCollections
        .where()
        .sortByCreatedAt()
        .findAll();
    return collections.map((c) => c.toEntity()).toList();
  }

  @override
  Future<void> addList(TodoList list) async {
    final collection = TodoListCollection.fromEntity(list);
    await isar.writeTxn(() => isar.todoListCollections.put(collection));
  }

  @override
  Future<void> updateList(TodoList list) async {
    final existing = await isar.todoListCollections
        .filter()
        .uuidEqualTo(list.id)
        .findFirst();
    if (existing == null) return;
    await isar.writeTxn(() async {
      existing.name = list.name;
      existing.createdAt = list.createdAt;
      await isar.todoListCollections.put(existing);
    });
  }

  @override
  Future<void> deleteList(String id) async {
    final existing = await isar.todoListCollections
        .filter()
        .uuidEqualTo(id)
        .findFirst();
    if (existing == null) return;
    final items = await isar.todoItemCollections
        .filter()
        .listIdEqualTo(id)
        .findAll();

    await isar.writeTxn(() async {
      await isar.todoListCollections.delete(existing.id);
      if (items.isNotEmpty) {
        await isar.todoItemCollections.deleteAll(
          items.map((item) => item.id).toList(),
        );
      }
    });
  }
}
