// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
      totalCounts: json['totalCounts'] as int,
      totalMoney: (json['totalMoney'] as num)?.toDouble(),
      products: json['products']);
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'totalCounts': instance.totalCounts,
      'totalMoney': instance.totalMoney,
      'products': instance.products
    };

SkuWapper _$SkuWapperFromJson(Map<String, dynamic> json) {
  return SkuWapper(
      skuId: json['skuId'] as String,
      sku: json['sku'] == null
          ? null
          : CartProduct.fromJson(json['sku'] as Map<String, dynamic>));
}

Map<String, dynamic> _$SkuWapperToJson(SkuWapper instance) =>
    <String, dynamic>{'skuId': instance.skuId, 'sku': instance.sku};

CartProduct _$CartProductFromJson(Map<String, dynamic> json) {
  return CartProduct(
      skuId: json['skuId'] as String,
      amount: json['amount'] as int,
      price: (json['price'] as num)?.toDouble(),
      freight: json['freight'] as int,
      norms: json['norms'] as String,
      name: json['name'] as String,
      url: json['url'] as String);
}

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
    <String, dynamic>{
      'skuId': instance.skuId,
      'amount': instance.amount,
      'price': instance.price,
      'freight': instance.freight,
      'norms': instance.norms,
      'name': instance.name,
      'url': instance.url
    };
