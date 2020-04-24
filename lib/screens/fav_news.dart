import 'package:flutter/material.dart';
import 'package:simonews/components/search_news.dart';

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
        body: Container(),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.language), title: Text("Notizie")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star_border),
                  title: Text("Segui"))
            ],
            onTap: (i) {
              if (i == 0) Navigator.pushNamed(context, "/");
            }));
  }
}
