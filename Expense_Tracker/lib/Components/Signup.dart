// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace

import 'package:expense_tracker/Methods/AuthClass.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 150, 10, 50),
        child: Column(
          children: [
            Card(
              child: Container(
                height: 160,
                width: 160,
                child: Center(child: Image.asset('assest/1.png')),
              ),
              elevation: 10,
              color: Color.fromARGB(255, 61, 57, 107),
              shadowColor: Colors.blueAccent,
              margin: EdgeInsets.all(20),
              shape: CircleBorder(
                side: BorderSide(width: 1.5, color: Colors.blue),
              ),
            ),
            SizedBox(
              height: 200,
              width: 250,
              child: Image.asset('assest/up.png'),
            ),
            Center(
              child: ElevatedButton(
                child: Text('Google'),
                onPressed: () {
                  AuthMethods().SignWithGoogle(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
