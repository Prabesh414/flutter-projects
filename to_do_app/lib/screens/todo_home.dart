import 'package:flutter/material.dart';
import '../constants/app_constants.dart' as app_constants;
import '../models/todo_item.dart';
import '../widgets/input_card.dart';
import '../widgets/todo_item_widget.dart';

class ToDoHome extends StatefulWidget {
  const ToDoHome({Key? key}) : super(key: key);

  @override
  State<ToDoHome> createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  final List<ToDoItem> _toDoItems = [];

  var appTitle = app_constants.appTitle;

  late final TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();

    _addSampleItems();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _addSampleItems() {
    var item1 = const ToDoItem(title: 'Learn Widget Trees', isCompleted: false);

    final item2 = const ToDoItem(
      title: 'Understand Elements',
      isCompleted: false,
    );

    const item3 = ToDoItem(
      title: 'Master State Management',
      isCompleted: false,
    );

    _toDoItems.addAll([item1, item2, item3]);
  }

  void _addToDoItem(String title) {
    if (title.isEmpty || title.length > app_constants.maxTitleLength) return;

    setState(() {
      var newItem = ToDoItem(title: title, isCompleted: false);
      _toDoItems.add(newItem);
      _titleController.clear();
    });
  }

  void _toggleComplete(int index) {
    setState(() {
      final item = _toDoItems[index];
      _toDoItems[index] = ToDoItem(
        title: item.title,
        isCompleted: !item.isCompleted,
      );
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _toDoItems.removeAt(index);
    });
  }

  void _editItem(int index) {
    final item = _toDoItems[index];
    final controller = TextEditingController(text: item.title);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(
          controller: controller,
          maxLength: app_constants.maxTitleLength,
          decoration: const InputDecoration(
            hintText: 'Edit your task...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _toDoItems[index] = ToDoItem(
                    title: controller.text,
                    isCompleted: item.isCompleted,
                  );
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(app_constants.appTitle),
        centerTitle: true,
      ),
      body: Column(
        children: [
          InputCard(
            controller: _titleController,
            onAdd: _addToDoItem,
            maxLength: app_constants.maxTitleLength,
          ),
          Expanded(
            child: _toDoItems.isEmpty
                ? Center(
                    child: Text(
                      app_constants.emptyListMessage,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                : ListView.builder(
                    itemCount: _toDoItems.length,
                    itemBuilder: (context, index) {
                      var item = _toDoItems[index];
                      return ToDoItemWidget(
                        item: item,
                        index: index,
                        onToggle: _toggleComplete,
                        onDelete: _deleteItem,
                        onEdit: _editItem,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
