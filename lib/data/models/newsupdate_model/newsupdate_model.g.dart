// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newsupdate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsupdateModel _$NewsupdateModelFromJson(Map<String, dynamic> json) =>
    NewsupdateModel(
      status: json['status'] as String?,
      totalResults: (json['totalResults'] as num?)?.toInt(),
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsupdateModelToJson(NewsupdateModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };
