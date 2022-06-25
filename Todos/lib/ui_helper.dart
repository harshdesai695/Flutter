// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

Widget cards(
  Color c,
  Icon k,
  String t1,
) {
  return Container(
    decoration:
        BoxDecoration(color: c, borderRadius: BorderRadius.circular(15)),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          k,
          SizedBox(
            height: 5,
          ),
          Text(
            t1,
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.blueGrey),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    ),
    height: 150,
    width: 150,
  );
}
