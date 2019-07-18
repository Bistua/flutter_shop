// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderdetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) {
  return OrderDetail(
      json['orderId'] as String,
      json['status'] as int,
      json['receiveGoods'] == null
          ? null
          : Address.fromJson(json['receiveGoods'] as Map<String, dynamic>),
      json['express'] as String,
      (json['goods'] as List)
          ?.map((e) =>
              e == null ? null : Good.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['createTime'] as String,
      json['payType'] as String,
      json['orderPrice'] as String,
      json['freight'] as String,
      json['payFee'] as String);
}

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'status': instance.status,
      'receiveGoods': instance.receiveGoods,
      'express': instance.express,
      'goods': instance.goods,
      'createTime': instance.createTime,
      'payType': instance.payType,
      'orderPrice': instance.orderPrice,
      'freight': instance.freight,
      'payFee': instance.payFee
    };
