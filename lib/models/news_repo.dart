import 'package:flutter/foundation.dart';
import 'package:simonews/services/api.dart';

import 'article.dart';

class NewsRepo extends ChangeNotifier {
  final List<Article> _articles = [];
  final Map<String, List<Article>> _articlesMap = Map();
  final List<Article> _favourites = [];
  Article _selected;

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

  // ignore: unnecessary_getters_setters
  Article get selected => _selected;

  // ignore: unnecessary_getters_setters
  set selected(Article article) => _selected = article;

  void addToMap(String key, List<Article> news) {
    assert(news != null);
    _articlesMap[key] = news;
    notifyListeners();
  }

  List<Article> getArticlesByCategory(String category) {
    if (category.isEmpty)
      return articles;
    else
      return _articlesMap[category] == null ? List() : _articlesMap[category];
  }
}
