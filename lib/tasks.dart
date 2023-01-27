import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/utils/app_colors.dart';

class Tasks extends StatefulWidget {
  const Tasks({
    super.key,
  });

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text('No tasks to display');
          } else {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                Color taskColor = AppColors.blueShadeColor;
                var taskTag = data['taskTag'];
                if (taskTag == 'Work') {
                  taskColor = AppColors.salmonColor;
                } else if (taskTag == 'School') {
                  taskColor = AppColors.greenShadeColor;
                }
                return Container(
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                        offset: Offset(0.0, 5),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 20,
                      height: 20,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: taskColor,
                      ),
                    ),
                    title: Text(data['taskName']),
                    subtitle: Text(data['taskDesc']),
                    isThreeLine: true,
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
