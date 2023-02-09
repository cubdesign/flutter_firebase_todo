// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('main test', (WidgetTester tester) async {
    final firestore = FakeFirebaseFirestore();

    DocumentReference docRef = await firestore
        .collection("tasks")
        .add({'taskName': "タスク名", 'taskDesc': "説明", 'taskTag': "Work"});

    String taskId = docRef.id;
    await firestore.collection('tasks').doc(taskId).update(
      {'id': taskId},
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: TodoApp(
        firestore: firestore,
      ),
    ));

    expect(find.text('No tasks to display'), findsOneWidget);

    // Let the snapshots stream fire a snapshot.
    await tester.idle();
    // Re-render.
    await tester.pump();

    expect(find.text('No tasks to display'), findsNothing);

    expect(find.text('タスク名'), findsOneWidget);
    expect(find.text('説明'), findsOneWidget);
  });
}
