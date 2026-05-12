import 'package:isar_community/isar.dart';

part 'todo_list_collection.g.dart';

@collection
class TodoListCollection {
  Id id = Isar.autoIncrement;
  late String uuid;
  late String name;
  late DateTime createdAt;

  @Index()
  String? get uuidIndex => uuid;
}
