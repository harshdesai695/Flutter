// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names

import 'package:expense_tracker/Components/AddItem.dart';
import 'package:expense_tracker/Components/DrawerPage.dart';
import 'package:expense_tracker/Components/Expenese_Container.dart';
import 'package:expense_tracker/Components/PieChart.dart';
import 'package:expense_tracker/Methods/AuthClass.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyExpenses'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                AuthMethods().signoutgoogle(context);
              },
              icon: Icon(Icons.exit_to_app_rounded))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Piechart(),
          ExpenceContainer(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddItems()),
          );
        },
        child: Icon(Icons.add),
      ),
      drawer: DrawerPage(),
    );
  }
}
