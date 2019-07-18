// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderComment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderComment _$OrderCommentFromJson(Map<String, dynamic> json) {
  return OrderComment(
      json['orderId'] as String,
      (json['goodsEvaluates'] as List)
          ?.map((e) =>
              e == null ? null : Goods.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$OrderCommentToJson(OrderComment instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'goodsEvaluates': instance.goodsEvaluates
    };

Goods _$GoodsFromJson(Map<String, dynamic> json) {
  return Goods(json['productId'] as String, json['content'] as String,
      json['level'] as String);
}

Map<String, dynamic> _$GoodsToJson(Goods instance) => <String, dynamic>{
      'productId': instance.productId,
      'content': instance.content,
      'level': instance.level
    };
