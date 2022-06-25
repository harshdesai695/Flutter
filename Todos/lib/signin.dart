// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'authclass.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              // decoration: BoxDecoration(color: Colors.amberAccent),
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                child: Image.asset('lib/images/ic_launcher.png'),
                // backgroundImage: container(AssetImage('lib/images/ic_launcher.png'),)P
              ),
              // Image.asset(
              //   'lib/images/ic_launcher.png',
              // ),
            ),
            InkWell(
              onTap: () {
                AuthMethons().SignWithGoogle(context);
              },
              child: Ink(
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 139, 174, 235),
                    radius: 40,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 139, 174, 235),
                      backgroundImage: AssetImage('lib/images/g2.png'),
                      radius: 35,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
