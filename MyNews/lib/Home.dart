// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:mynews/Ctile.dart';

import 'package:mynews/Models/Article_model.dart';
import 'package:mynews/Services/Api_services.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiService client = ApiService();
  String category = '';

  @override
  void initState() {
    category = '';

    super.initState();
  }

  final cat = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'Sports',
    'Technology'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Padding(
        padding: const EdgeInsets.only(top: 20),
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
                itemCount: cat.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cat[index]),
                    onTap: () {
                      setState(() {
                        category = cat[index];
                        Navigator.of(context).pop();
                      });
                    },
                  );
                })
          ],
        ),
      )),
      appBar: AppBar(
        title: Text("MyNews"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: client.getArticle(category),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Article> articles = snapshot.data;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) => ListTile(
                title: customListTile(articles[index], context),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
