import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simonews/components/news_item.dart';
import 'package:simonews/components/search_news.dart';
import 'package:simonews/models/news_repo.dart';
import 'package:simonews/services/db_repo.dart';

class FavNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            )),
        body: getItems(),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.language), title: Text("Notizie")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star_border), title: Text("Segui"))
            ],
            onTap: (i) {
              if (i == 0) Navigator.pushNamed(context, "/");
            }));
  }

  Center getItems() {
    DbRepository dbRepository = DbRepository();

    return Center(child: Consumer<NewsRepo>(builder: (context, holder, child) {
      return ListView.builder(
          itemCount: dbRepository.getArticles() == null
              ? 0
              : dbRepository.getArticles().length,
          itemBuilder: (context, position) =>
              NewsItem(dbRepository.getArticles()[position]));
    }));
  }
}
