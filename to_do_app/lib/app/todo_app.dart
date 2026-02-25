import 'package:flutter/material.dart';
import '../screens/todo_home.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To-Do App',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ToDoHome(),
    );
  }
}
