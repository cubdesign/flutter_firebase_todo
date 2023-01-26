import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/add_task_alert_dialog.dart';
import 'package:flutter_firebase_todo/my_home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'To-Do List'),
      home: const AddTaskAlertDialog(title: 'AddTaskAlertDialog'),
    );
  }
}
