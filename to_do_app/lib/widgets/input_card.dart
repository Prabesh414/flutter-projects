import 'package:flutter/material.dart';

class InputCard extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onAdd;
  final int maxLength;

  const InputCard({
    Key? key,
    required this.controller,
    required this.onAdd,
    required this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                maxLength: maxLength,
                decoration: const InputDecoration(
                  hintText: 'Add a new task...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: FloatingActionButton(
                onPressed: () => onAdd(controller.text),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
