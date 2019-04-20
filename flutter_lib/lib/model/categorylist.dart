import 'package:flutter_lib/model/category.dart';

class CategoryList {
  List<Category> list;

  CategoryList({this.list});


  factory CategoryList.fromJson(List<dynamic> parsedJson) {

    var list = parsedJson.map((i)=>Category.fromJson(i)).toList();

    return new CategoryList(
      list: list,
    );
  }

}
