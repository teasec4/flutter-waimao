import 'package:isar_community/isar.dart';
import 'package:paste_tool/domain/entities/todo_item.dart';

part 'todo_item_collection.g.dart';

@collection
class TodoItemCollection {
  Id id = Isar.autoIncrement;
  late String uuid;
  late String text;
  late bool isDone;
  late String listId;
  late int sortOrder;
  late DateTime createdAt;

  @Index()
  String? get uuidIndex => uuid;

  @Index()
  String? get listIndex => listId;

  TodoItem toEntity() => TodoItem(
    id: uuid,
    text: text,
    isDone: isDone,
    listId: listId,
    sortOrder: sortOrder,
    createdAt: createdAt,
  );

  static TodoItemCollection fromEntity(TodoItem entity) => TodoItemCollection()
    ..uuid = entity.id
    ..text = entity.text
    ..isDone = entity.isDone
    ..listId = entity.listId
    ..sortOrder = entity.sortOrder
    ..createdAt = entity.createdAt;
}
