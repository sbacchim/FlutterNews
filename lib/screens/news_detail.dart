import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:simonews/models/article.dart';
import 'package:simonews/models/news_repo.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatefulWidget {
  NewsDetail();

  @override
  State<StatefulWidget> createState() {
    return _NewsDetailState();
  }
}

class _NewsDetailState extends State<NewsDetail> {
  Article article;

  @override
  Widget build(BuildContext context) {
    article = Provider.of<NewsRepo>(context, listen: false).selected;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            'SimoNews',
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: article.url,
            ))
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  Share.share('Condividi\n${article.url}');
                }),
            IconButton(icon: Icon(Icons.add))
          ],
        )));
  }
}
