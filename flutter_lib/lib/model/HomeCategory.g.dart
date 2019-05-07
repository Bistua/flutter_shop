// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCategory _$HomeCategoryFromJson(Map<String, dynamic> json) {
  return HomeCategory(
      json['categoryName'] as String,
      json['categoryImgUrl'] as String,
      json['sortNum'] as int,
      json['categoryId'] as String);
}

Map<String, dynamic> _$HomeCategoryToJson(HomeCategory instance) =>
    <String, dynamic>{
      'categoryName': instance.categoryName,
      'categoryImgUrl': instance.categoryImgUrl,
      'sortNum': instance.sortNum,
      'categoryId': instance.categoryId
    };
