// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types

import 'dart:math';

import 'package:flutter/material.dart';

class myDrawer extends StatelessWidget {
  myDrawer({Key? key}) : super(key: key);
  final category = [
    'business',
    'entertainment',
    'general',
    'health',
    'science',
    'sports',
    'technology'
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Expanded(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/ic_launcher.png'),
            Text(
              'MyNews',
              style: TextStyle(
                fontSize: 35,
                shadows: [
                  Shadow(
                    color: Colors.blue,
                    blurRadius: 10.0,
                    // offset: Offset(5.0, 5.0),
                  ),
                  Shadow(
                    color: Colors.red,
                    blurRadius: 10.0,
                    // offset: Offset(-5.0, 5.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: category.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(category[index]),
                    onTap: () {},
                  );
                })
          ],
        ),
      ),
    ));
  }
}
