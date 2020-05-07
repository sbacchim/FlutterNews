import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:simonews/models/article.dart';
import 'package:simonews/models/news_repo.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:simonews/services/db_repo.dart';


class NewsDetail extends StatefulWidget {
  NewsDetail();

  @override
  State<StatefulWidget> createState() {
    return _NewsDetailState();
  }
}

class _NewsDetailState extends State<NewsDetail> {
  Article article;
  DbRepository box = DbRepository();

  @override
  void initState() {
    super.initState();

  }

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
            IconButton(icon: Icon(Icons.add), onPressed: () {
              box.addArticle(article);
              showDialog(context: context, child: Positioned(
                  left: 16,
                  right: 16,
                  top: 32,
                  child: Card(
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 8,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          Text("Welcome to Japan!",
                              style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                          Text(
                              "Mount Fuji (called by the japanese \"Fujisan\") located on the island of Honshū, is the highest mountain in Japan, standing 3,776.24 metres (12,389.2 ft).")
                        ],
                      ),
                    ),
                  )));
            })
          ],
        )));
  }

  Future<T> showDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    @Deprecated(
        'Instead of using the "child" argument, return the child from a closure '
            'provided to the "builder" argument. This will ensure that the BuildContext '
            'is appropriate for widgets built in the dialog. '
            'This feature was deprecated after v0.2.3.'
    )
    Widget child,
    WidgetBuilder builder,
    bool useRootNavigator = true,
  }) {
    assert(child == null || builder == null);
    assert(useRootNavigator != null);
    assert(debugCheckHasMaterialLocalizations(context));

    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
        final Widget pageChild = child ?? Builder(builder: builder);
        return SafeArea(
          child: Builder(
              builder: (BuildContext context) {
                return theme != null
                    ? Theme(data: theme, child: pageChild)
                    : pageChild;
              }
          ),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 150),  useRootNavigator: useRootNavigator,
    );
  }
}
