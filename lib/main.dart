import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/app/app.dart';
import 'package:flutter_firebase_todo/app/app_config.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final tags = await fetchTags();
  AppConfig().tags = tags;

  runApp(TodoApp(firestore: firestore));
}

Future<List<String>> fetchTags() async {
  final fireStore = FirebaseFirestore.instance;
  final collectionRef = fireStore.collection('task-tags');
  final querySnapshot = await collectionRef.get();
  final queryDocSnapshot = querySnapshot.docs;
  List<String> tags = [];
  for (final snapshot in queryDocSnapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    tags.add(data["title"]);
  }
  return tags;
}
