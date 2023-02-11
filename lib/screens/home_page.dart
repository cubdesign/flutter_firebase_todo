import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/widgets/tasks.dart';

import '../widgets/add_task_alert_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.firestore, required this.title});

  final String title;
  final FirebaseFirestore firestore;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = widget.firestore;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: PageView(
        children: <Widget>[Center(child: Tasks(firestore: firestore))],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AddTaskAlertDialog(firestore: firestore);
              });
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
