import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simonews/bloc/news_bloc.dart';
import 'package:simonews/components/news_item.dart';
import 'package:simonews/components/search_news.dart';
import 'package:simonews/models/article.dart';
import 'package:simonews/models/news_repo.dart';
import 'package:simonews/services/db_repo.dart';

DbRepository _dbRepo = DbRepository();

class News extends StatefulWidget {
  News({Key key}) : super(key: key);

  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with TickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _dbRepo.watch().forEach((element) {
      print("Update");
    });
    final bloc = Provider.of<NewsBloc>(context, listen: false);
    bloc.getNews();
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
              bottomNavigationBar: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.language), title: Text("Notizie")),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.star_border), title: Text("Segui"))
                  ],
                  onTap: (i) {
                    if (i == 1) Navigator.pushNamed(context, "/fav");
                  })));
    });
  }

  void _onTabClick() async {
    if (!_controller.indexIsChanging) {
      final bloc = Provider.of<NewsBloc>(context, listen: false);
      bloc.changeCategory(_controller.index);
    }
  }

  Center getItem(String category) {
    final bloc = Provider.of<NewsBloc>(context, listen: false);
    bloc.getNews();
    return Center(
        child: RefreshIndicator(
            onRefresh: () => bloc.refresh(_controller.index),
            child: StreamBuilder<List<Article>>(
                stream: bloc.articles,
                builder: (context, AsyncSnapshot<List<Article>> snapshot) {
                  return (snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, position) =>
                              NewsItem(snapshot.data[position]))
                      : Center(child: CircularProgressIndicator()));
                })));
  }
}
