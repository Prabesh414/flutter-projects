import 'package:flutter/material.dart';
import '../models/todo_item.dart';

class ToDoItemWidget extends StatelessWidget {
  final ToDoItem item;
  final int index;
  final Function(int) onToggle;
  final Function(int) onDelete;
  final Function(int)? onEdit;

  const ToDoItemWidget({
    Key? key,
    required this.item,
    required this.index,
    required this.onToggle,
    required this.onDelete,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: item.isCompleted,
        onChanged: (_) => onToggle(index),
      ),
      title: Text(
        item.title,
        style: TextStyle(
          decoration: item.isCompleted
              ? TextDecoration.lineThrough
              : TextDecoration.none,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => onEdit!(index),
            ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => onDelete(index),
          ),
        ],
      ),
    );
  }
}
