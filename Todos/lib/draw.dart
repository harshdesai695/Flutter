// ignore_for_file: unused_import, prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todos/authclass.dart';
import 'package:todos/databasehelper.dart';
import 'package:todos/signin.dart';
import 'package:todos/todoscreen.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final _auth = FirebaseAuth.instance;
  String uname = '';

  void initState() {
    super.initState();
    getusername();
  }

  getusername() {
    uname = _auth.currentUser!.displayName!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Color(0xFf80cbc4),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 50, 5, 0),
          child: Column(
            children: <Widget>[
              DrawerHeader(
                child: Image.asset('lib/images/ic_launcher.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Center(
                    child: Text(
                  '$uname',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      child: ListTile(
                        style: ListTileStyle.list,
                        title: Text("Completed Todos"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TodoScreen(
                                      id: 'Complete',
                                    )),
                          );
                        },
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: ListTile(
                        style: ListTileStyle.list,
                        title: Text("Notification"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TodoScreen(
                                      id: 'Complete',
                                    )),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    AuthMethons().signoutgoogle(context);
                    Navigator.pop(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => SignIn()),
                    // );
                  },
                  child: Text('Logout'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
