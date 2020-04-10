import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:simonews/models/article.dart';

const String BASE_URL = "http://newsapi.org/v2";
const String HEADLINES = "/top-headlines";
const String EVERYTHING = "/everything";
const String API_KEY = "b94a8a91e8cb44f890483f4f753d625f";
const String COUNTRY = "it";

class Api {
  Api();

  Future<List<Article>> getArticles() async {
    String url =
        BASE_URL + HEADLINES + "?country=" + COUNTRY + "&apiKey=" + API_KEY;

    http.Response response = await http.get(url);

    return _parseArticle(response.body);
  }

  static List<Article> _parseArticle(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed['articles']
        .map<Article>((json) => Article.fromJson(json))
        .toList();
  }
}
