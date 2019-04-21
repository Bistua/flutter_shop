// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductList _$ProductListFromJson(Map<String, dynamic> json) {
  return ProductList(
      totalCount: json['totalCount'] as String,
      list: (json['list'] as List)
          ?.map((e) => e == null
              ? null
              : ProductItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ProductListToJson(ProductList instance) =>
    <String, dynamic>{'totalCount': instance.totalCount, 'list': instance.list};
