import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:providerskel/data/models/newsupdate_model/article.dart';
import 'package:providerskel/data/models/newsupdate_model/newsupdate_model.dart';
import 'package:providerskel/helpers/api_const.dart';
import 'package:providerskel/helpers/api_helpers/api_helpers.dart';

class NewaRepository {
  Future<Either<String, List<Article>>> news() async {
    var res = await ApiHelper().get(baseUrl);
    print(res);
    if (res is Response) {
      if (res.statusCode == 200 || res.statusCode == 201) {
        NewsupdateModel newsupdates = NewsupdateModel.fromJson(res.data);

        List<Article>? newsList = newsupdates.articles ?? [];
        print(newsList);
        // List<NewsupdateModel> filtered = [];
        // for (int i = 0; i < bannerList.length; i++) {
        //   bannerList[i].photoInfo!.filesystem == 's3'
        //       ? filtered.add(bannerList[i])
        //       : null;
        // }
        // print(filtered);
        return Right(newsList);
      } else {
        return const Left("");
      }
    }
    return const Left("");
  }
}
