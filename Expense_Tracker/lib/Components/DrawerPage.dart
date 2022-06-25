// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  String uname = '';
  String imgurl = '';
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    Onstartup();
  }

  Onstartup() {
    setState(() {
      uname = auth.currentUser!.displayName!;
      imgurl = (auth.currentUser!.photoURL!);
    });
  }

  imgwidget() {
    try {
      return Image.network(imgurl);
    } catch (e) {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Center(
            child: Column(
          children: [
            Card(
              child: Container(
                height: 160,
                width: 160,
                child: Center(child: imgwidget()),
              ),
              elevation: 10,
              color: Color.fromARGB(255, 149, 207, 236),
              shadowColor: Colors.blueAccent,
              margin: EdgeInsets.all(20),
              shape: CircleBorder(
                side: BorderSide(width: 1.5, color: Colors.blue),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 149, 207, 236),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent)),
              child: ListTile(
                title: Text(
                  uname,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Divider(
              thickness: 1, // thickness of the line
              indent: 20, // empty space to the leading edge of divider.
              endIndent: 20, // empty space to the trailing edge of the divider.
              color: Colors.grey, // The color to use when painting the line.
              height: 5, // The divider's height extent.
            ),
          ],
        )),
      ),
    );
  }
}
