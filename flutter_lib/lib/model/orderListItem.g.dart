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
              e == null ? null : Product.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      orderNumber: json['orderId'] as String,
      orderTime: json['orderTime'] as String,
      payMode: json['payMode'] as String,
      productTotal:json['productTotal'],
      freight: json['freight'] ,
      payPrice:json['buyAllPrice']);
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
