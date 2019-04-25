// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordergoods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderGoods _$OrderGoodsFromJson(Map<String, dynamic> json) {
  return OrderGoods(json['goodsId'] as String, json['buyNum'] as String);
}

Map<String, dynamic> _$OrderGoodsToJson(OrderGoods instance) =>
    <String, dynamic>{'goodsId': instance.goodsId, 'buyNum': instance.buyNum};
