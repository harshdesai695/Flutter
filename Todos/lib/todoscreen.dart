// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, unnecessary_string_interpolations

import 'package:carbon_icons/carbon_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'database.dart';

class TodoScreen extends StatefulWidget {
  String id;
  TodoScreen({required this.id});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  String ids = '';
  String? myemail = '';
  String value = "";
  String todoid = "";
  String temail = '';
  Stream? todostream;
  late int con;
  var td = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blueGrey,
    ).copyWith(
      secondary: Colors.green,
    ),
    textTheme: const TextTheme(bodyText2: TextStyle(color: Colors.purple)),
  );
  final FirebaseAuth auth = FirebaseAuth.instance;
  final todocontrol = TextEditingController();
  @override
  void initState() {
    super.initState();
    onstartup();
  }

  onstartup() async {
    await getmydata();
    theams();
    getmytodo();
    setid();
  }

  theams() {
    if (widget.id == "Work") {
      con = 0xffC889D2;
      td = ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color.fromARGB(255, 205, 94, 223),
              secondary: Colors.blue));
    } else if (widget.id == "Home") {
      con = 0xFfffcdd2;
      td = ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color.fromARGB(255, 161, 115, 118),
              secondary: Colors.blue));
    } else if (widget.id == "Health") {
      con = 0xFffff59d;
      td = ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color.fromARGB(255, 207, 194, 78),
              secondary: Colors.blue));
    } else if (widget.id == "Private") {
      con = 0xFfffccbc;
      td = ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color.fromARGB(255, 243, 151, 123),
              secondary: Colors.blue));
    } else if (widget.id == "Study") {
      con = 0xFfe6ee9c;
      td = ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color.fromARGB(255, 207, 194, 78),
              secondary: Colors.blue));
    } else if (widget.id == "All") {
      con = 0xFFD1C4E9;
      td = ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color.fromARGB(255, 133, 108, 179),
              // primary: Color.fromARGB(255, 145, 103, 223),
              secondary: Colors.blue));
    } else if (widget.id == "Complete") {
      con = 0xFFD1C4E9;
      td = ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color.fromARGB(255, 133, 108, 179),
              // primary: Color.fromARGB(255, 145, 103, 223),
              secondary: Colors.blue));
    }
    setState(() {});
  }

  getmytodo() async {
    todostream = await DatabaseMethod().gettodo(myemail, widget.id);
    if (widget.id == 'All') {
      todostream = await DatabaseMethod().getalltodo(myemail, widget.id);
    }
    if (widget.id == "Complete") {
      todostream = await DatabaseMethod().getcompletetodo(myemail);
    }
    setState(() {});
  }

  setid() {
    setState(() {
      ids = widget.id;
    });
  }

  getmydata() async {
    // myemail = (await Sharepref().getUserEmail());
    myemail = auth.currentUser!.email;
    setState(() {});
  }

  addtodo() {
    String todo = todocontrol.text;
    var tstamp = DateTime.now();
    Map<String, dynamic> todosdata = {
      'Email': myemail,
      'Todo': todo,
      'Category': widget.id,
      'Time': tstamp,
    };
    if (todoid == '') {
      todoid = randomAlphaNumeric(12);
    }
    DatabaseMethod()
        .addtodos(email: myemail!, tododata: todosdata, todoid: todoid)
        .then((value) {
      todocontrol.clear();
      todoid = '';
    });
  }

  updatetodo(String did) {
    String todo = todocontrol.text;
    var tstamp = DateTime.now();
    Map<String, dynamic> todosdata = {
      'Email': myemail,
      'Todo': todo,
      'Category': widget.id,
      'Time': tstamp,
    };
    DatabaseMethod()
        .updatetodos(email: myemail!, tododata: todosdata, todoid: did)
        .then((value) {
      todocontrol.clear();
    });
  }

  Deletetodo(String did) {
    DatabaseMethod().deletetodo(email: myemail!, todoid: did).then((value) {
      todocontrol.clear();
    });
  }

  Widget Todolist() {
    return StreamBuilder(
      stream: todostream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot snap = snapshot.data!.docs[index];
                  String docid = snap.id;
                  var datetime = snap['Time'].toDate();
                  var d12 = DateFormat('dd/MM').format(datetime);
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (widget.id == 'All' || widget.id == 'Complete')
                        ? null
                        : (direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              if (widget.id != "Complete") {
                                DatabaseMethod().sendtocompletetodo(
                                  email: myemail!,
                                  todoid: docid,
                                );
                                setState(() {});
                              }
                            } else {
                              todocontrol.text = snap['Todo'];
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Delete Todo"),
                                      content: Container(
                                        height: 50,
                                        child: Column(
                                          children: <Widget>[
                                            Text('Are You Sure Want to Delete')
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Deletetodo(docid);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    );
                                  });
                              setState(() {});
                            }
                          },
                    background: (widget.id == 'All' || widget.id == 'Complete')
                        ? Container()
                        : Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                    secondaryBackground:
                        (widget.id == 'All' || widget.id == 'Complete')
                            ? Container()
                            : Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                margin: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(con),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 13.0,
                                // spreadRadius: 5.0,
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: (widget.id == 'All' ||
                                    widget.id == 'Complete')
                                ? null
                                : IconButton(
                                    onPressed: () {
                                      todocontrol.text = snap['Todo'];
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Update Todo"),
                                              content: Container(
                                                height: 50,
                                                child: Column(
                                                  children: <Widget>[
                                                    TextField(
                                                      controller: todocontrol,
                                                      onChanged: (text) {
                                                        value = text;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        hintText: 'Update Todo',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    updatetodo(docid);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('Update'),
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    icon: Icon(Icons.edit)),
                            title: Text(snap['Todo']),
                            trailing: Text(d12),
                          ),
                        )),
                  );
                }) // ListView.builder
            : Center(child: Text('No!! Todo Added Yet'));
      },
    ); // StreamBuilder
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: td,
      child: Scaffold(
        floatingActionButton: (ids == 'All' || ids == 'Complete')
            ? Container()
            : FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Add what Todo"),
                          content: Container(
                            height: 50,
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: todocontrol,
                                  onChanged: (text) {
                                    value = text;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter Todo',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                addtodo();
                                Navigator.pop(context, 'Ok');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      });
                },
                child: Icon(CarbonIcons.add),
              ),
        appBar: AppBar(
          title: Text(widget.id),
        ),
        body: Todolist(),
      ),
    );
  }
}
