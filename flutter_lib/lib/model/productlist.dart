import 'package:flutter_lib/model/productitem.dart';

class ProductList{


  String totalCount;
  List<ProductItem> list;

  ProductList({this.totalCount, this.list});

  factory ProductList.fromJson(dynamic result) {
    print("ProductList");
    print(result);
    String total = result["totalCount"];
    List<dynamic> parsedJson = result["list"];
    var list = parsedJson.map((i) => ProductItem.fromJson(i)).toList();

    return ProductList(
      totalCount:total,
      list: list,
    );
  }
}