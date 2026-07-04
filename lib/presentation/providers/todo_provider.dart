import 'package:flutter/foundation.dart';

import 'package:paste_tool/domain/entities/todo_item.dart';
import 'package:paste_tool/domain/entities/todo_list.dart';
import 'package:paste_tool/domain/usecases/manage_todo_items.dart';
import 'package:paste_tool/domain/usecases/manage_todo_lists.dart';

class TodoProvider extends ChangeNotifier {
  final ManageTodoLists _manageLists;
  final ManageTodoItems _manageItems;

  TodoProvider(this._manageLists, this._manageItems) {
    loadLists();
  }

  List<TodoList> _lists = [];
  List<TodoItem> _items = [];
  TodoList? _activeList;
  bool _loading = true;
  String? _lastError;

  List<TodoList> get lists => _lists;
  List<TodoItem> get items => _items;
  TodoList? get activeList => _activeList;
  bool get loading => _loading;
  String? get lastError => _lastError;

  void clearError() {
    _lastError = null;
  }

  Future<void> loadLists() async {
    _loading = true;
    notifyListeners();
    try {
      _lists = await _manageLists.getLists();
    } catch (e) {
      _lastError = 'Error loading lists: $e';
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> addList(String name) async {
    try {
      await _manageLists.addList(name);
      await loadLists();
    } catch (e) {
      _lastError = 'Error creating list: $e';
      notifyListeners();
    }
  }

  Future<void> renameList(String id, String name) async {
    try {
      await _manageLists.renameList(id, name);
      await loadLists();
    } catch (e) {
      _lastError = 'Error renaming: $e';
      notifyListeners();
    }
  }

  Future<void> deleteList(String id) async {
    try {
      await _manageLists.deleteList(id);
      await loadLists();
    } catch (e) {
      _lastError = 'Error deleting list: $e';
      notifyListeners();
    }
  }

  Future<void> selectList(TodoList list) async {
    _activeList = list;
    notifyListeners();
    await _loadItems();
  }

  Future<void> backToLists() async {
    _activeList = null;
    _items = [];
    notifyListeners();
  }

  Future<void> addItem(String text) async {
    if (_activeList == null) return;
    try {
      final maxOrder = _items.isEmpty
          ? 0
          : _items.map((i) => i.sortOrder).reduce((a, b) => a > b ? a : b) + 1;
      await _manageItems.addItem(text, _activeList!.id, sortOrder: maxOrder);
      await _loadItems();
    } catch (e) {
      _lastError = 'Error creating task: $e';
      notifyListeners();
    }
  }

  Future<void> editItem(String itemId, String newText) async {
    final item = _items.firstWhere((i) => i.id == itemId);
    try {
      await _manageItems.editItem(item, newText);
      await _loadItems();
    } catch (e) {
      _lastError = 'Error editing task: $e';
      notifyListeners();
    }
  }

  Future<void> toggleDone(String itemId) async {
    final item = _items.firstWhere((i) => i.id == itemId);
    try {
      await _manageItems.toggleDone(item);
      await _loadItems();
    } catch (e) {
      _lastError = 'Error updating task: $e';
      notifyListeners();
    }
  }

  Future<void> deleteItem(String itemId) async {
    try {
      await _manageItems.deleteItem(itemId);
      await _loadItems();
    } catch (e) {
      _lastError = 'Error deleting task: $e';
      notifyListeners();
    }
  }

  Future<void> _loadItems() async {
    if (_activeList == null) return;
    try {
      _items = await _manageItems.getItems(_activeList!.id);
    } catch (e) {
      _lastError = 'Error loading tasks: $e';
    }
    notifyListeners();
  }
}
