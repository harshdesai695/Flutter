// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expense_tracker/Components/Signup.dart';
import 'package:expense_tracker/HomePage.dart';
import 'package:expense_tracker/Methods/AuthClass.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: AuthMethods().getcurrentuser(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return SignUp();
          }
        },
      ),
    );
  }
}
