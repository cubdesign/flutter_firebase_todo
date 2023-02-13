import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/widgets/task.dart';
import 'package:flutter_firebase_todo/app/app_colors.dart';

class Tasks extends StatefulWidget {
  final FirebaseFirestore firestore;
  const Tasks({
    super.key,
    required this.firestore,
  });

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = widget.firestore;

    return Container(
      margin: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('No tasks to display');
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Task(
                    taskColor: _getTaskColor(data),
                    data: data,
                    firestore: firestore);
              }).toList(),
            );
          }
        },
      ),
    );
  }

  Color _getTaskColor(Map<String, dynamic> data) {
    Color taskColor = AppColors.blueShadeColor;
    var taskTag = data['taskTag'];
    if (taskTag == 'Work') {
      taskColor = AppColors.salmonColor;
    } else if (taskTag == 'School') {
      taskColor = AppColors.greenShadeColor;
    }

    return taskColor;
  }
}
