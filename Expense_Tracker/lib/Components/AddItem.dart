// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, non_constant_identifier_names, unnecessary_new

import 'package:expense_tracker/Components/Piechart.dart';
import 'package:expense_tracker/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../Methods/DatabseMethods.dart';

class AddItems extends StatefulWidget {
  const AddItems({Key? key}) : super(key: key);

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  String itemname = "";
  String itemcost = "";
  String itemid = "";
  String? myemail = "";
  String Dvalue = 'Food';

  var Ditems = [
    'Food',
    'Shopping',
    'Housing',
    'Transportation',
    'Investment',
    'Health',
    'Grocery',
    'Other'
  ];

  final itemnamecontrol = TextEditingController();
  final itemcostcontrol = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Onstartup();
  }

  Onstartup() {
    getmydata();
  }

  getmydata() async {
    setState(() {
      myemail = auth.currentUser!.email;
    });
  }

  Widget Dropmenu() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton(
        isExpanded: true,
        value: Dvalue,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: Ditems.map((String Ditems) {
          return DropdownMenuItem(
            value: Ditems,
            child: Text("  " + Ditems),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            Dvalue = value!;
          });
        },
      ),
    );
  }

  additem() {
    String itemname = itemnamecontrol.text;
    String itemcost = itemcostcontrol.text;
    var tstamp = DateTime.now();
    Map<String, dynamic> itemsdata = {
      'Email': myemail,
      'Item': itemname,
      'Cost': itemcost,
      'Category': Dvalue,
      'Time': tstamp,
    };
    if (itemid == '') {
      itemid = randomAlphaNumeric(12);
    }
    DatabaseMethods()
        .additems(email: myemail!, itemdata: itemsdata, itemid: itemid)
        .then((value) {
      itemnamecontrol.clear();
      itemcostcontrol.clear();
      itemid = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Items'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 400,
            child: Card(
              elevation: 8,
              shadowColor: Colors.green,
              margin: EdgeInsets.all(20),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue, width: 2)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextField(
                          controller: itemnamecontrol,
                          onChanged: (text) {
                            itemname = text;
                          },
                          decoration: InputDecoration(
                              labelText: 'Enter Item',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.red),
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: itemcostcontrol,
                          onChanged: (text) {
                            itemcost = text;
                          },
                          decoration: InputDecoration(
                              labelText: 'Enter Cost',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.red),
                                borderRadius: BorderRadius.circular(15),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Dropmenu(),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          additem();
                          setState(() {
                            Dvalue = 'Food';
                          });
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        },
                        child: const Text('ADD'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          itemnamecontrol.clear();
                          itemcostcontrol.clear();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        },
                        child: const Text('Cancle'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        //
      ),
    );
  }
}
