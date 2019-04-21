// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderResult _$OrderResultFromJson(Map<String, dynamic> json) {
  return OrderResult(
      tradeOrderId: json['tradeOrderId'] as String,
      goodsDesc: json['goodsDesc'] as String,
      attach: json['attach'] as String);
}

Map<String, dynamic> _$OrderResultToJson(OrderResult instance) =>
    <String, dynamic>{
      'tradeOrderId': instance.tradeOrderId,
      'goodsDesc': instance.goodsDesc,
      'attach': instance.attach
    };
