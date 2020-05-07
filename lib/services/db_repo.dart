import 'package:hive/hive.dart';
import 'package:simonews/main.dart';
import 'package:simonews/models/article.dart';

class DbRepository {
  Box<Article> favorites = Hive.box(newsBox);

  addArticle(Article article) => favorites.put(article.id, article);

  List<Article> getArticles() => favorites.values.toList();

  watch() => favorites.watch();
}
