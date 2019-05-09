// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) {
  return Promotion(
      json['promotionTitle'] as String,
      json['promotionDesc'] as String,
      json['productId'] as String,
      json['sellPrice'] as String,
      json['promotionPrice'] as String,
      json['imgUrl'] as String);
}

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      'promotionTitle': instance.promotionTitle,
      'promotionDesc': instance.promotionDesc,
      'productId': instance.productId,
      'sellPrice': instance.sellPrice,
      'promotionPrice': instance.promotionPrice,
      'imgUrl': instance.imgUrl
    };
