import 'package:flutter_lib/model/productitem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'productlist.g.dart';

@JsonSerializable()
class ProductList {
  String totalCount;
  List<ProductItem> list;

  ProductList({this.totalCount, this.list});

  factory ProductList.fromJson(Map<String, dynamic> json) =>
      _$ProductListFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListToJson(this);
}
