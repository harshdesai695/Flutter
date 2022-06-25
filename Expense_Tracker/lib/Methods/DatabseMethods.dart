// ignore_for_file: file_names

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
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

  additems(
      {required String email,
      required Map<String, dynamic> itemdata,
      required String itemid}) async {
    return FirebaseFirestore.instance
        .collection('UserItem')
        .doc(email)
        .collection('Items')
        .doc(itemid)
        .set(itemdata);
  }

  Future<Stream<QuerySnapshot>> getallitem(email) async {
    return FirebaseFirestore.instance
        .collection('UserItem')
        .doc(email)
        .collection('Items')
        .orderBy('Time', descending: true)
        .snapshots();
  }

  getcost(email) async {
    List dataList = [];
    List catelist = [];
    List costlist = [0, 0, 0, 0, 0, 0, 0, 0];
    var snap = await FirebaseFirestore.instance
        .collection('UserItem')
        .doc(email)
        .collection('Items')
        .get()
        .then((QuerySnapshot snapshot) => {
              snapshot.docs.forEach((f) => {
                    dataList.add(f.get('Cost')),
                    catelist.add(f.get('Category'))
                  })
            });
    for (int i = 0; i < catelist.length; i++) {
      if (catelist[i] == 'Food') {
        costlist[0] = costlist[0] + int.parse(dataList[i]);
      } else if (catelist[i] == 'Shopping') {
        costlist[1] = costlist[1] + int.parse(dataList[i]);
      } else if (catelist[i] == 'Housing') {
        costlist[2] = costlist[2] + int.parse(dataList[i]);
      } else if (catelist[i] == 'Transportation') {
        costlist[3] = costlist[3] + int.parse(dataList[i]);
      } else if (catelist[i] == 'Investment') {
        costlist[4] = costlist[4] + int.parse(dataList[i]);
      } else if (catelist[i] == 'Health') {
        costlist[5] = costlist[5] + int.parse(dataList[i]);
      } else if (catelist[i] == 'Grocery') {
        costlist[6] = costlist[6] + int.parse(dataList[i]);
      } else if (catelist[i] == 'Other') {
        costlist[7] = costlist[7] + int.parse(dataList[i]);
      }
    }
    return costlist;
  }
}
