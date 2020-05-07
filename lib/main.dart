import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simonews/models/article.dart';
import 'package:simonews/screens/fav_news.dart';
import 'package:simonews/screens/news.dart';
import 'package:simonews/screens/news_detail.dart';
import 'package:simonews/theme/theme.dart';
import 'package:simonews/services//db_repo.dart';

import 'models/news_repo.dart';

const String newsBox = "newsBox";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  await Hive.openBox<Article>(newsBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return ChangeNotifierProvider(
      create: (context) => NewsRepo(),
      child: MaterialApp(
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        title: 'SimoNews',
        initialRoute: '/',
        routes: {
          '/': (context) => News(),
          '/detail': (context) => NewsDetail(),
          '/fav': (context) => FavNews(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
