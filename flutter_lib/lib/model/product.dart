import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
///
///   {
//                "id": 3,
//                "skuId": 3,
//                "name": "Hoppin' Hot Sauce",
//                "description": "Tangy, ripe cayenne peppes flow together with garlic, onion, tomato paste and a hint of cane sugar to make this a smooth sauce with a bite.  Wonderful on eggs, poultry, pork, or fish, this sauce blends to make rich marinades and soups.",
//                "metaTitle": null,
//                "price": 4.99,
//                "medias": {
//                    "alt1": {
//                        "id": 302,
//                        "url": "/cmsstatic/img/sauces/Hoppin-Hot-Sauce-Close.jpg",
//                        "title": "Hoppin Hot Sauce Close-up",
//                        "altText": "alt1",
//                        "tags": null
//                    },
//                    "primary": {
//                        "id": 301,
//                        "url": "/cmsstatic/img/sauces/Hoppin-Hot-Sauce-Bottle.jpg",
//                        "title": "Hoppin Hot Sauce Bottle",
//                        "altText": "primary",
//                        "tags": null
//                    }
//                }
//            },
///
///
///
@JsonSerializable()
class Product {
  String skuId;
  String name;
  String image;
  double rating;
  String price;
  double priceNum;
  String brand;
  String description;
  int totalReviews;
  List<String> sizes;
  //List<ProductColor> colors;
  int quantity = 0;
  int count = 0;
  bool isChecked = false;
  List<int> size;
  List<String> color;

  Product({
    this.skuId,
    this.name,
    this.image,
    this.brand,
    this.price,
    this.priceNum,
    this.rating,
    this.description,
    this.totalReviews,
    this.sizes,
    //this.colors,
    this.quantity,
    this.count,
    this.size,
    this.color,
  });

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
