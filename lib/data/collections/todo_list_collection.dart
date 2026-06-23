import 'package:isar_community/isar.dart';
import 'package:paste_tool/domain/entities/todo_list.dart';

part 'todo_list_collection.g.dart';

@collection
class TodoListCollection {
  Id id = Isar.autoIncrement;
  late String uuid;
  late String name;
  late DateTime createdAt;

  @Index()
  String? get uuidIndex => uuid;

  TodoList toEntity() => TodoList(id: uuid, name: name, createdAt: createdAt);

  static TodoListCollection fromEntity(TodoList entity) => TodoListCollection()
    ..uuid = entity.id
    ..name = entity.name
    ..createdAt = entity.createdAt;
}
