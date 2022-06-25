// ignore_for_file: file_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/Article_model.dart';

class ApiService {
  final endPointUrl = "newsapi.org";
  final client = http.Client();
  Future<List<Article>> getArticle(String Category) async {
    final queryParameters = {
      'country': 'in',
      'category': Category,
      'apiKey': 'Your Api Key'
    };
    final uri = Uri.https(endPointUrl, '/v2/top-headlines', queryParameters);
    final response = await client.get(uri);
    Map<String, dynamic> json = jsonDecode(response.body);
    List<dynamic> body = json['articles'];
    List<Article> articles =
        body.map((dynamic item) => Article.fromJson(item)).toList();
    return articles;
  }
}
