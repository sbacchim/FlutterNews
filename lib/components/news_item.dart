import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simonews/models/article.dart';

@immutable
class NewsItem extends StatelessWidget {
  final Article item;

  NewsItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16),
        child: Column(children: <Widget>[
          Card(
              margin: EdgeInsets.all(16),
              elevation: 2,
              child: Container(
                  width: 600,
                  child: Image(
                      image: NetworkImage(
                          item.urlToImage == null ? "" : item.urlToImage),
                      fit: BoxFit.fitWidth))),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                item.author == null ? "" : item.author,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 8.0)),
              Text(
                item.title == null ? "" : item.title,
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              Text(
                item.publishedAt == null ? "" : convertDate(item.publishedAt),
                maxLines: 2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              )
            ],
          )
        ]));
  }

  convertDate(String publishedAt) {}
}
