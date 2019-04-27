// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'productitem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductItem _$ProductItemFromJson(Map<String, dynamic> json) {
  return ProductItem(
      id: json['id'] as int,
      skuId: json['skuId'] as int ,
      name: json['name'] as String,
      description: json['description'] as String,
      metaTitle: json['metaTitle'] as String,
      price: (json['price'] as num)?.toDouble(),
      medias: json['medias'] == null
          ? null
          : ProductMedias.fromJson(json['medias'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ProductItemToJson(ProductItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'skuId': instance.skuId,
      'name': instance.name,
      'description': instance.description,
      'metaTitle': instance.metaTitle,
      'price': instance.price,
      'medias': instance.medias
    };

ProductMedias _$ProductMediasFromJson(Map<String, dynamic> json) {
  return ProductMedias(
      alt1: json['alt1'] == null
          ? null
          : Alt.fromJson(json['alt1'] as Map<String, dynamic>),
      primary: json['primary'] == null
          ? null
          : Alt.fromJson(json['primary'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ProductMediasToJson(ProductMedias instance) =>
    <String, dynamic>{'alt1': instance.alt1, 'primary': instance.primary};

Alt _$AltFromJson(Map<String, dynamic> json) {
  return Alt(
      id: json['id'] as int,
      url: json['url'] as String,
      title: json['title'] as String,
      altText: json['altText'] as String,
      tags: json['tags'] as String);
}

Map<String, dynamic> _$AltToJson(Alt instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'title': instance.title,
      'altText': instance.altText,
      'tags': instance.tags
    };
