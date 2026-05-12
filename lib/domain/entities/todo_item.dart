class TodoItem {
  final String id;
  final String text;
  final bool isDone;
  final String listId;
  final int sortOrder;
  final DateTime createdAt;

  const TodoItem({
    required this.id,
    required this.text,
    this.isDone = false,
    required this.listId,
    required this.sortOrder,
    required this.createdAt,
  });
}
