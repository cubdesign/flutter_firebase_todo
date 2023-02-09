import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteTaskAlertDialog extends StatefulWidget {
  final String taskId, taskName;
  final FirebaseFirestore firestore;

  const DeleteTaskAlertDialog(
      {Key? Key,
      required this.firestore,
      required this.taskId,
      required this.taskName})
      : super(key: Key);

  @override
  State<DeleteTaskAlertDialog> createState() => _DeleteTaskAlertDialogState();
}

class _DeleteTaskAlertDialogState extends State<DeleteTaskAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text(
        'Delete Task',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.brown),
      ),
      content: SizedBox(
        child: Form(
          child: Column(
            children: <Widget>[
              const Text(
                'Are you sure you want to delete this task?',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 15),
              Text(
                widget.taskName.toString(),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            _deleteTasks();
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }

  Future _deleteTasks() async {
    final FirebaseFirestore firestore = widget.firestore;

    var collection = firestore.collection('tasks');
    collection
        .doc(widget.taskId)
        .delete()
        .then(
          (_) => Fluttertoast.showToast(
              msg: "Task deleted successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0),
        )
        .catchError(
          (error) => Fluttertoast.showToast(
              msg: "Failed: $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0),
        );
    ;
  }
}
