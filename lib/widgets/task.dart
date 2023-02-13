import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/app/app_colors.dart';
import 'package:flutter_firebase_todo/widgets/delete_task_alert_dialog.dart';
import 'package:flutter_firebase_todo/widgets/update_task_alert_dialog.dart';

class Task extends StatelessWidget {
  const Task({
    Key? key,
    required this.taskColor,
    required this.data,
    required this.firestore,
  }) : super(key: key);

  final Color taskColor;
  final Map<String, dynamic> data;
  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
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
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 'edit',
                child: const Text(
                  'Edit',
                  style: TextStyle(fontSize: 13.0),
                ),
                onTap: () {
                  String taskId = (data['id']);
                  String taskName = (data['taskName']);
                  String taskDesc = (data['taskDesc']);
                  String taskTag = (data['taskTag']);
                  Future.delayed(
                    const Duration(seconds: 0),
                    () => showDialog(
                      context: context,
                      builder: (context) => UpdateTaskAlertDialog(
                        firestore: firestore,
                        taskId: taskId,
                        taskName: taskName,
                        taskDesc: taskDesc,
                        taskTag: taskTag,
                      ),
                    ),
                  );
                },
              ),
              PopupMenuItem(
                value: 'delete',
                child: const Text(
                  'Delete',
                  style: TextStyle(fontSize: 13.0),
                ),
                onTap: () {
                  String taskId = (data['id']);
                  String taskName = (data['taskName']);
                  Future.delayed(
                    const Duration(seconds: 0),
                    () => showDialog(
                      context: context,
                      builder: (context) => DeleteTaskAlertDialog(
                          firestore: firestore,
                          taskId: taskId,
                          taskName: taskName),
                    ),
                  );
                },
              ),
            ];
          },
        ),
        dense: true,
      ),
    );
  }
}
