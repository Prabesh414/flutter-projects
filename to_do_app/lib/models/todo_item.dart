class ToDoItem {
  final String title;
  final bool isCompleted;

  const ToDoItem({required this.title, required this.isCompleted});

  @override
  String toString() => 'ToDoItem(title: $title, completed: $isCompleted)';
}
