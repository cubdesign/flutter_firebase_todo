import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/screens/home_page.dart';

class TodoApp extends StatelessWidget {
  final FirebaseFirestore firestore;

  const TodoApp({super.key, required this.firestore});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'To-Do List', firestore: firestore),
    );
  }
}
