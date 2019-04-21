// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
      totalCounts: json['totalCounts'] as int,
      totalMoney: (json['totalMoney'] as num)?.toDouble(),
      products: (json['products'] as List)
          ?.map((e) =>
              e == null ? null : SkuWapper.fromJson(e as Map<String, dynamic>))
          ?.toList());
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
      productId: json['productId'] as String,
      skuId: json['skuId'] as String,
      amount: json['amount'] as int,
      price: (json['price'] as num)?.toDouble(),
      freight: (json['freight'] as num)?.toDouble(),
      norms: json['norms'] as String,
      name: json['name'] as String,
      img: json['img'] as String);
}

Map<String, dynamic> _$CartProductToJson(CartProduct instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'skuId': instance.skuId,
      'amount': instance.amount,
      'price': instance.price,
      'freight': instance.freight,
      'norms': instance.norms,
      'name': instance.name,
      'img': instance.img
    };
