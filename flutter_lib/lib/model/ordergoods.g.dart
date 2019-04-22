// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ordergoods.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderGoods _$OrderGoodsFromJson(Map<String, dynamic> json) {
  return OrderGoods(json['skuId'] as String, json['buyNum'] as String);
}

Map<String, dynamic> _$OrderGoodsToJson(OrderGoods instance) =>
    <String, dynamic>{'skuId': instance.skuId, 'buyNum': instance.buyNum};
