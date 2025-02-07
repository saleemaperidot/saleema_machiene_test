import 'package:json_annotation/json_annotation.dart';

import 'article.dart';

part 'newsupdate_model.g.dart';

@JsonSerializable()
class NewsupdateModel {
  String? status;
  int? totalResults;
  List<Article>? articles;

  NewsupdateModel({this.status, this.totalResults, this.articles});

  factory NewsupdateModel.fromJson(Map<String, dynamic> json) {
    return _$NewsupdateModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NewsupdateModelToJson(this);
}
