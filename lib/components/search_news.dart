import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simonews/models/news_repo.dart';
import 'package:simonews/services/api.dart';

import 'news_item.dart';

class SearchNews extends SearchDelegate<String> {
  SearchNews();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      query.isNotEmpty
          ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                query = '';
                Provider.of<NewsRepo>(context, listen: false).clearSearch();
              })
          : Container()
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      _search(context, query);
    }

    return Consumer<NewsRepo>(builder: (context, holder, child) {
      return ListView.builder(
          itemCount: query.isNotEmpty ? 0 : holder.getSearched(query).length,
          itemBuilder: (context, position) =>
              NewsItem(holder.getSearched(query)[position]));
    });
  }

  @override
  String get searchFieldLabel => "Search...";

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  void _search(BuildContext context, String search) async {
    await Api().searchArticles(context: context, search: search);
  }
}
