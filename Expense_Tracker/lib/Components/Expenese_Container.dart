// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/Methods/DatabseMethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ExpenceContainer extends StatefulWidget {
  const ExpenceContainer({Key? key}) : super(key: key);

  @override
  State<ExpenceContainer> createState() => _ExpenceContainerState();
}

class _ExpenceContainerState extends State<ExpenceContainer> {
  Stream? itemstream;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isselected = false;
  Color? tilecolor = Colors.white;
  @override
  void initState() {
    super.initState();
    getallitem();
  }

  getallitem() async {
    String myemail = auth.currentUser!.email!;
    itemstream = await DatabaseMethods().getallitem(myemail);
    setState(() {});
  }

  tileselection() {
    setState(() {
      if (isselected) {
        tilecolor = Colors.white;
        isselected = false;
      } else {
        tilecolor = Colors.grey;
        isselected = true;
      }
    });
  }

  Widget Itemlist() {
    return StreamBuilder(
        stream: itemstream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot snap = snapshot.data!.docs[index];
                    // String docid = snap.id;
                    return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: tilecolor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blueAccent)),
                          child: ListTile(
                            selected: isselected,
                            onLongPress: tileselection,
                            title: Text(snap['Item']),
                            trailing: Text('Rs. ' + snap['Cost']),
                            subtitle: Text(snap['Category']),
                          ),
                        ));
                  })
              : Center(child: Text('No Item Found'));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        child: Itemlist(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blueAccent)),
      ),
    );
    ;
  }
}
