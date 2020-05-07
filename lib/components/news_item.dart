import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:simonews/models/article.dart';
import 'package:simonews/models/news_repo.dart';
import 'package:simonews/utils/SimoNewsUtils.dart';
import 'package:url_launcher/url_launcher.dart';

@immutable
class NewsItem extends StatelessWidget {
  final Article item;

  NewsItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(4, 0, 4, 4),
        child: InkWell(
            onTap: () {
              kIsWeb ? openNewsUrl(item.url) : _openNewsDetail(context);
            },
            child: Column(children: <Widget>[
              Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  margin: EdgeInsets.all(16),
                  elevation: 2,
                  child: Container(
                      width: 350,
                      height: 220,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                              imageUrl: item.urlToImage == null
                                  ? ""
                                  : item.urlToImage,
                              placeholder: (context, url) => Center(
                                  widthFactor: 1.0,
                                  heightFactor: 1.0,
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.image))))),
              Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  width: 600,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.source == null ? "" : item.source,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 4.0)),
                      Text(
                        item.title == null ? "" : item.title.split(" - ")[0],
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 8.0)),
                      Text(
                        item.publishedAt == null
                            ? ""
                            : SimoNewsUtils.getArticleDate(item.publishedAt),
                        maxLines: 2,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12.0,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 8.0))
                    ],
                  )),
              Divider(
                  color: Colors.grey[70],
                  thickness: 1,
                  height: 8.0,
                  indent: 4.0,
                  endIndent: 4.0)
            ])));
  }

  openNewsUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error launching $url';
    }
  }

  _openNewsDetail(BuildContext context) {
    Provider.of<NewsRepo>(context, listen: false).selected = item;
    Navigator.pushNamed(context, '/detail');
  }
}
