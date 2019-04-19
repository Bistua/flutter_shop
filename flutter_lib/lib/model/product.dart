import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

class Product {
  String name;
  String image;
  double rating;
  String price;
  double priceNum;
  String brand;
  String description;
  int totalReviews;
  List<String> sizes;
  List<ProductColor> colors;
  int quantity = 0;
  int count = 0;
  bool isChecked = false;
  List<int> size;
  List<String> color;

  Product(
      {this.name,
      this.image,
      this.brand,
      this.price,
      this.priceNum,
      this.rating,
      this.description,
      this.totalReviews,
      this.sizes,
      this.colors,
      this.quantity,
      this.count,
      this.size,
      this.color,});

  @override
  bool operator ==(other) {
    return other is Product && other.name == this.name;
  }

  static List<Product> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Product>((json) => Product.fromJson(json)).toList();
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      image: json['image'],
    );
  }
}

class ProductColor {
  final String colorName;
  final MaterialColor color;

  ProductColor({this.colorName, this.color});
}
