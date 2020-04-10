import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simonews/components/news_item.dart';
import 'package:simonews/models/article.dart';
import 'package:simonews/models/news_repo.dart';

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
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
                leading: Icon(Icons.search, color: Colors.grey),
                title: Text(
                  'SimoNews',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                bottom: TabBar(
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
                children: <Widget>[
                  Container(
                    child: Center(
                        child: ListView.builder(
                      itemBuilder: (context, index) =>
                          NewsItem((news.articles[index]) as Article),
                      itemCount: (news.articles as List).length,
                    )),
                  ),
                  Container(
                    child: Center(
                      child: Text('Tab 2'),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Tab 3'),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Tab 4'),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Tab 5'),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Tab 6'),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text('Tab 7'),
                    ),
                  )
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.language), title: Text("Notizie")),
                BottomNavigationBarItem(
                    icon: Icon(Icons.star_border), title: Text("Segui"))
              ])));
    });
  }
}
