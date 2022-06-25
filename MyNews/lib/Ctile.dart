// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Models/Article_model.dart';

Widget customListTile(Article article, BuildContext context) {
  _launchURLApp(url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  return InkWell(
    onTap: () {
      _launchURLApp(article.url);
    },
    child: Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (article.urlToImage != 'null'
              ? Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(article.urlToImage),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                )
              : Container(
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://source.unsplash.com/user/weekly?coding'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                )),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Text(
              article.source.name,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            article.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            article.description,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    ),
  );
}
