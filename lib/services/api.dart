import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simonews/models/article.dart';
import 'package:simonews/models/news_repo.dart';

const String BASE_URL = "http://newsapi.org/v2";
const String HEADLINES = "/top-headlines";
const String EVERYTHING = "/everything";
const String API_KEY = "b94a8a91e8cb44f890483f4f753d625f";
const String COUNTRY = "it";

class Api {
  final Dio dio = Dio();
  final DioCacheManager cacheManager =
      DioCacheManager(CacheConfig(baseUrl: BASE_URL));

  Api() {
    dio.options.baseUrl = BASE_URL;
    dio.options.connectTimeout = 5000;
    dio.transformer = FlutterTransformer();
    dio.interceptors.add(cacheManager.interceptor);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      Map<String, dynamic> params = options.queryParameters;
      params['apiKey'] = API_KEY;
      options.queryParameters = params;
      return options;
    }, onResponse: (Response response) async {
      // Do something with response data
      return response; // continue
    }, onError: (DioError e) async {
      // Do something with response error
      return e; //continue
    }));
  }

  Future<List<Article>> getArticles() async {
    String url = HEADLINES + "?country=" + COUNTRY + "&apiKey=" + API_KEY;

    Response response =
        await dio.get(url, options: buildCacheOptions(Duration(seconds: 30)));

    return await response.data['articles']
        .map<Article>((json) => Article.fromJson(json))
        .toList();
  }

  Future<void> getArticlesByCategory(
      {@required BuildContext context, String category}) async {
    var articlesHolder = Provider.of<NewsRepo>(context, listen: false);
    String _category = '&category=' + category;
    String url = BASE_URL +
        HEADLINES +
        "?country=" +
        COUNTRY +
        (_category.isEmpty ? "" : _category) +
        "&apiKey=" +
        API_KEY;
    Response response = await dio.get(url);
    List<Article> articles = await response.data['articles']
        .map<Article>((json) => Article.fromJson(json))
        .toList();
    articlesHolder.addToMap(category, articles);
  }

  searchArticles({BuildContext context, String search}) async {
    var articlesHolder = Provider.of<NewsRepo>(context, listen: false);
    String _search = '?q=' + search;

    String url =
        HEADLINES + (search.isEmpty ? "" : _search) + "&apiKey=" + API_KEY;

    Response response = await dio.get(url);

    List<Article> news = await response.data['articles']
        .map<Article>((json) => Article.fromJson(json))
        .toList();
    articlesHolder.addResults(news);
  }
}
