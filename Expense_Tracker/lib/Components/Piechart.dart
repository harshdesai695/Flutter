// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:expense_tracker/Methods/DatabseMethods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Piechart extends StatefulWidget {
  const Piechart({Key? key}) : super(key: key);

  @override
  State<Piechart> createState() => _PiechartState();
}

class _PiechartState extends State<Piechart> {
  String myemail = '';
  List t = [];
  num csum = 0;
  Map<String, double> dataMap = {
    'Food': 0,
    'Shopping': 0,
    'Housing': 0,
    'Transportation': 0,
    'Investment': 0,
    'Health': 0,
    'Grocery': 0,
    'Other': 0
  };

  @override
  void initState() {
    super.initState();
    OnstartupPiechart();
  }

  OnstartupPiechart() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    myemail = auth.currentUser!.email!;
    t = await DatabaseMethods().getcost(myemail);
    getcostsum(t);
    setState(() {
      dataMap = {
        'Food': t[0].toDouble(),
        'Shopping': t[1].toDouble(),
        'Housing': t[2].toDouble(),
        'Transportation': t[3].toDouble(),
        'Investment': t[4].toDouble(),
        'Health': t[5].toDouble(),
        'Grocery': t[6].toDouble(),
        'Other': t[7].toDouble()
      };
    });
  }

  getcostsum(List t) {
    num sum = 0;
    for (int i = 0; i < t.length; i++) {
      sum = sum + t[i];
    }
    setState(() {
      csum = sum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.blueAccent),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[500]!,
                  offset: const Offset(4, 4),
                  blurRadius: 15,
                  spreadRadius: 1),
            ]),
        // child: Center(child: Text('PieChart')),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Center(
            child: PieChart(
              chartType: ChartType.ring,
              centerText: csum == 0 ? 'Empty' : 'Total\n' + csum.toString(),
              dataMap: dataMap,
              chartValuesOptions:
                  ChartValuesOptions(showChartValuesInPercentage: true),
            ),
          ),
        ),
      ),
    );
  }
}
