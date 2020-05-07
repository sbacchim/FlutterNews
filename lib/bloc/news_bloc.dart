import 'dart:async';

import 'package:simonews/models/article.dart';
import 'package:simonews/services/api.dart';
import 'package:simonews/services/db_repo.dart';

enum CategoriesEnum {
  general,
  business,
  entertainment,
  health,
  science,
  sports,
  technology
}

String categoryName(CategoriesEnum category) =>
    category.toString().split('.').last;

class NewsBloc {

  NewsBloc();

  final Api _news = Api();
  CategoriesEnum _actualCategory = CategoriesEnum.general;

  Stream<List<Article>> get articles => _articles.stream;

  Stream<CategoriesEnum> get actualCategory => _screenController.stream;

  final DbRepository _dbRepository = DbRepository();

  Article _article;

  Article selectedArticle;

  final StreamController<CategoriesEnum> _screenController =
  StreamController<CategoriesEnum>.broadcast();
  final StreamController<List<Article>> _articles =
  StreamController<List<Article>>.broadcast();

  changeCategory(int index) {
    _actualCategory = CategoriesEnum.values[index];
    _articles.sink.add(null); //Clear news
    _screenController.sink.add(_actualCategory);
    getNews();
  }

  getNews() async {
    List<Article> response =
    await _news.getArticlesByCategory(category: categoryName(_actualCategory));
    _articles.sink.add(response);
  }

  Future<bool> refresh(int index) async {
    _actualCategory = CategoriesEnum.values[index];
    _articles.sink.add(null); //Clear news
    getNews();
    return true;
  }

  void handleSearch(String search) async {
    List<Article> response = await _news.searchArticles(search: search);
    _articles.sink.add(response);
  }

  void addToFav(bool isAddedToFav) {
    isAddedToFav
        ? _dbRepository.addArticle(_article)
        : _dbRepository.deleteArticle(_article);
  }

  dispose() {
    _screenController?.close();
    _articles?.close();
  }
}