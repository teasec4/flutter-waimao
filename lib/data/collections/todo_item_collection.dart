import 'package:isar_community/isar.dart';

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
}
