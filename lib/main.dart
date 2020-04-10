import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simonews/screens/fav_news.dart';
import 'package:simonews/screens/news.dart';
import 'package:simonews/screens/news_detail.dart';
import 'package:simonews/screens/search_news.dart';

import 'models/news_repo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return ChangeNotifierProvider(
      create: (context) => NewsRepo(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Roboto',
            brightness: Brightness.light
        ),
        debugShowCheckedModeBanner: false,
        title: 'SimoNews',
        initialRoute: '/',
        routes: {
          '/': (context) => News(),
//          '/detail': (context) => NewsDetail(),
//          '/search': (context) => SearchNews(),
//          '/fav': (context) => FavNews(),
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
