import '../entities/todo_list.dart';

abstract class TodoListRepository {
  Future<List<TodoList>> getLists();
  Future<void> addList(TodoList list);
  Future<void> updateList(TodoList list);
  Future<void> deleteList(String id);
}
