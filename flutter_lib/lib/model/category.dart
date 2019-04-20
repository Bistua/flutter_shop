import 'package:flutter/material.dart';

class Category {
  int id;
  String name;
  String image;

  Category({this.id, this.name, this.image});

  factory Category.fromJson(Map<String, dynamic> result) {
    return new Category(
      id: result['id'],
      name: result['name'],
      image: result['thumbnail'],
    );
  }
}
