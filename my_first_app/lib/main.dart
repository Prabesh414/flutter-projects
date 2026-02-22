import 'package:flutter/material.dart';
import 'package:my_first_app/prabesh_practice.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: PrabeshPractice(
          const Color.fromARGB(255, 57, 27, 128),
          const Color.fromARGB(255, 203, 201, 207),
        ),
      ),
    ),
  );
}
