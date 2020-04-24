import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simonews/components/news_item.dart';
import 'package:simonews/models/news_repo.dart';
import 'package:simonews/services/api.dart';

import 'file:///C:/Users/simoneb/Desktop/CorsoFlutter/simo_news/lib/components/search_news.dart';

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 7, vsync: this);
    _controller.addListener(() {
      _onTabClick();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsRepo>(builder: (context, news, child) {
      return DefaultTabController(
          length: 7,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: IconButton(
                    icon: Icon(Icons.search, color: Colors.grey),
                    onPressed: () {
                      showSearch(context: context, delegate: SearchNews());
                    }),
                title: Text(
                  'SimoNews',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                bottom: TabBar(
                    controller: _controller,
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: 'Generale'),
                      Tab(text: 'Affari'),
                      Tab(text: 'Intrattenimento'),
                      Tab(text: 'Salute'),
                      Tab(text: 'Scienza'),
                      Tab(text: 'Tecnologia'),
                      Tab(text: 'Sport')
                    ]),
              ),
              body: TabBarView(
                controller: _controller,
                children: <Widget>[
                  Container(child: getItem("")),
                  Container(child: getItem("business")),
                  Container(child: getItem("entertainment")),
                  Container(child: getItem("health")),
                  Container(child: getItem("science")),
                  Container(child: getItem("technology")),
                  Container(child: getItem("sports")),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.language), title: Text("Notizie")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.star_border), title: Text("Segui"))
              ], onTap: (i) {
                if (i == 1)
                  Navigator.pushNamed(context, "/fav");
              })));
    });
  }

  void _onTabClick() async {
    switch (_controller.index) {
      case 0:
        await Api().getArticles();
        break;
      case 1:
        await Api()
            .getArticlesByCategory(context: context, category: "business");
        break;
      case 2:
        await Api()
            .getArticlesByCategory(context: context, category: "entertainment");
        break;
      case 3:
        await Api().getArticlesByCategory(context: context, category: "health");
        break;
      case 4:
        await Api()
            .getArticlesByCategory(context: context, category: "science");
        break;
      case 5:
        await Api()
            .getArticlesByCategory(context: context, category: "technology");
        break;
      case 6:
        await Api().getArticlesByCategory(context: context, category: "sports");
        break;
    }
  }

  Center getItem(String category) {
    return Center(
        child: RefreshIndicator(
            onRefresh: () => _refresh(context, category),
            child: Consumer<NewsRepo>(builder: (context, holder, child) {
              return ListView.builder(
                  itemCount: holder.getArticlesByCategory(category) == null
                      ? 0
                      : holder.getArticlesByCategory(category).length,
                  itemBuilder: (context, position) => NewsItem(
                      holder.getArticlesByCategory(category)[position]));
            })));
  }

  Future<bool> _refresh(BuildContext context, String category) async {
    if (category == null)
      await Api().getArticles();
    else
      await Api().getArticlesByCategory(context: context, category: category);
    return true;
  }
}
