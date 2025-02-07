import 'package:flutter/material.dart';
import 'package:providerskel/data/models/newsupdate_model/article.dart';

import 'package:providerskel/data/repos/news_repo.dart';
import 'package:providerskel/provider/custom_mixin.dart';

class NewsProvider with ChangeNotifier, CustomNotifierMixin {
  static final NewsProvider _singleton = NewsProvider._internal();
  NewsProvider._internal();
  bool isLoading = false;
  bool hasError = false;
  List<Article> news = [];
  factory NewsProvider() {
    return _singleton;
  }

  Future<List<Article>> getNews() async {
    isLoading = true;
    List<Article> newstemp = [];
    notifyListeners();
    await NewaRepository().news().then((value) {
      value.fold(
        (l) {
          isLoading = false;
          hasError = true;
          news = [];
          return false;
        },
        (r) {
          isLoading = false;
          hasError = false;
          news = r;

          print(r);

          return true;
        },
      );
    });
    notifyListeners();
    return news;
  }
}
