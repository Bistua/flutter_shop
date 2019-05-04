// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderListItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return OrderItem(
      status: json['status'] as int,
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      express: json['express'] as String,
      products: (json['goodsList'] as List)
          ?.map((e) =>
              e == null ? null : Good.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      orderNumber: json['orderId'] as String,
      orderTime: json['orderTime'] as String,
      payMode: json['payMode'] as String,
      productTotal: (json['productTotal'] as num)?.toDouble(),
      freight: (json['freight'] as num)?.toDouble(),
      payPrice: json['buyAllPrice'] as String);
}

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'status': instance.status,
      'address': instance.address,
      'express': instance.express,
      'goodsList': instance.products,
      'orderId': instance.orderNumber,
      'orderTime': instance.orderTime,
      'payMode': instance.payMode,
      'productTotal': instance.productTotal,
      'freight': instance.freight,
      'buyAllPrice': instance.payPrice
    };

Good _$GoodFromJson(Map<String, dynamic> json) {
  return Good(
      buyNum: json['buyNum'] as String,
      goodsId: json['goodsId'] as String,
      goodsName: json['goodsName'] as String,
      goodsPrice: json['goodsPrice'] as String)
    ..goodsImgUrl = json['goodsImgUrl'] as String;
}

Map<String, dynamic> _$GoodToJson(Good instance) => <String, dynamic>{
      'buyNum': instance.buyNum,
      'goodsId': instance.goodsId,
      'goodsName': instance.goodsName,
      'goodsPrice': instance.goodsPrice,
      'goodsImgUrl': instance.goodsImgUrl
    };
