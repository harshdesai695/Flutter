// ignore_for_file: avoid_print, unused_import

import 'package:carbon_icons/carbon_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'databasehelper.dart';

class DatabaseMethod {
  addUserdata({
    required String userID,
    required String email,
    required String username,
    required String name,
    required String profileUrl,
  }) async {
    await FirebaseFirestore.instance.collection("users").doc(userID).set({
      "email": email,
      "username": username,
      "name": name,
      "imgUrl": profileUrl,
    });
  }

  addtodos(
      {required String email,
      required Map<String, dynamic> tododata,
      required String todoid}) async {
    return FirebaseFirestore.instance
        .collection('UserTodo')
        .doc(email)
        .collection('Pending')
        .doc(todoid)
        .set(tododata);
  }

  Future<Stream<QuerySnapshot>> gettodo(email, category) async {
    return FirebaseFirestore.instance
        .collection('UserTodo')
        .doc(email)
        .collection('Pending')
        // .orderBy('Time', descending: true)
        .where('Category', isEqualTo: category)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getcompletetodo(email) async {
    return FirebaseFirestore.instance
        .collection('UserTodo')
        .doc(email)
        .collection('Complete')
        .orderBy('Time', descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getalltodo(email, category) async {
    return FirebaseFirestore.instance
        .collection('UserTodo')
        .doc(email)
        .collection('Pending')
        .orderBy('Time', descending: true)
        .snapshots();
  }

  updatetodos(
      {required String email,
      required Map<String, dynamic> tododata,
      required String todoid}) async {
    return FirebaseFirestore.instance
        .collection('UserTodo')
        .doc(email)
        .collection('Pending')
        .doc(todoid)
        .update(tododata);
  }

  sendtocompletetodo({required String email, required String todoid}) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserTodo')
        .doc(email)
        .collection('Pending')
        .doc(todoid)
        .get();
    String td = snapshot.get('Todo');
    String cate = snapshot.get('Category');
    var tstamp = DateTime.now();
    deletetodo(email: email, todoid: todoid);
    await FirebaseFirestore.instance
        .collection('UserTodo')
        .doc(email)
        .collection('Complete')
        .doc(todoid)
        .set({
      'Email': email,
      'Todo': td,
      'Category': cate,
      'Time': tstamp,
    });
  }

  deletetodo({required String email, required String todoid}) async {
    return FirebaseFirestore.instance
        .collection('UserTodo')
        .doc(email)
        .collection('Pending')
        .doc(todoid)
        .delete();
  }
}
