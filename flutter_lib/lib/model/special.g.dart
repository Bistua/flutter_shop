// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'special.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Special _$SpecialFromJson(Map<String, dynamic> json) {
  return Special(json['titleName'] as String, json['specialDesc'] as String,
      json['productId'] as String, json['imgUrl'] as String);
}

Map<String, dynamic> _$SpecialToJson(Special instance) => <String, dynamic>{
      'titleName': instance.titleName,
      'specialDesc': instance.specialDesc,
      'productId': instance.productId,
      'imgUrl': instance.imgUrl
    };
