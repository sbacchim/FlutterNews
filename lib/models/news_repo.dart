import 'package:flutter/foundation.dart';
import 'package:simonews/services/api.dart';

import 'article.dart';

class NewsRepo extends ChangeNotifier {

  final List<Article> _articles = [];

  NewsRepo() {
    Api().getArticles().then((value) => articles = value);
  }

  set articles(List<Article> news) {
    assert(news != null);
    // ignore: unnecessary_statements
    _articles.clear;
    _articles.addAll(news);
    notifyListeners();
  }

  get articles => _articles;

}