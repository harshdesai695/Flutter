// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:todos/todoscreen.dart';
import 'package:todos/ui_helper.dart';
import 'authclass.dart';
import 'package:carbon_icons/carbon_icons.dart';
import 'draw.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.teal,
        ).copyWith(
          secondary: Colors.green,
        ),
      ),
      child: Scaffold(
        backgroundColor: Color(0xFf80cbc4),
        drawer: DrawerScreen(),
        // backgroundColor: Color.fromARGB(0, 81, 173, 0),
        appBar: AppBar(
          title: Text('Home'),
          centerTitle: true,
          elevation: 5,
          backgroundColor: Color(0xFF00897B),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  InkWell(
                    child: cards(
                        Color.fromARGB(255, 229, 177, 236),
                        Icon(
                          Icons.work_outline,
                          color: Colors.blueGrey,
                          size: 40,
                        ),
                        'Work'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodoScreen(
                                  id: 'Work',
                                )),
                      );
                    },
                    highlightColor: Colors.green.withOpacity(0.5),
                    splashColor: Colors.green.withOpacity(0.5),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    child: cards(
                        Color(0xFfffcdd2),
                        Icon(
                          CarbonIcons.home,
                          color: Colors.blueGrey,
                          size: 40,
                        ),
                        'Home'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodoScreen(
                                  id: 'Home',
                                )),
                      );
                    },
                    highlightColor: Colors.blue.withOpacity(0.4),
                    splashColor: Colors.green.withOpacity(0.5),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  InkWell(
                    child: cards(
                        Color(0xFfffccbc),
                        Icon(
                          CarbonIcons.person,
                          color: Colors.blueGrey,
                          size: 40,
                        ),
                        'Private'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodoScreen(
                                  id: 'Private',
                                )),
                      );
                    },
                    highlightColor: Colors.blue.withOpacity(0.4),
                    splashColor: Colors.green.withOpacity(0.5),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    child: cards(
                        Color(0xFffff59d),
                        Icon(
                          Icons.healing,
                          color: Colors.blueGrey,
                          size: 40,
                        ),
                        'Health'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodoScreen(
                                  id: 'Health',
                                )),
                      );
                    },
                    highlightColor: Colors.blue.withOpacity(0.4),
                    splashColor: Colors.green.withOpacity(0.5),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  InkWell(
                    child: cards(
                        Color(0xFfe6ee9c),
                        Icon(
                          CarbonIcons.book,
                          color: Colors.blueGrey,
                          size: 40,
                        ),
                        'Study'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodoScreen(
                                  id: 'Study',
                                )),
                      );
                    },
                    highlightColor: Colors.blue.withOpacity(0.4),
                    splashColor: Colors.green.withOpacity(0.5),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    child: cards(
                        Color(0xFFD1C4E9),
                        Icon(
                          Icons.all_inbox,
                          color: Colors.blueGrey,
                          size: 40,
                        ),
                        'All'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodoScreen(
                                  id: 'All',
                                )),
                      );
                    },
                    highlightColor: Colors.blue.withOpacity(0.4),
                    splashColor: Colors.green.withOpacity(0.5),
                  ),
                  // InkWell(
                  //   child: cards(
                  //       Color(0xFfc5cae9),
                  //       Icon(
                  //         Icons.all_inbox,
                  //         color: Colors.blueGrey,
                  //         size: 40,
                  //       ),
                  //       'Complete'),
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => TodoScreen(
                  //                 id: 'Complete',
                  //               )),
                  //     );
                  //   },
                  //   highlightColor: Colors.blue.withOpacity(0.4),
                  //   splashColor: Colors.green.withOpacity(0.5),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
