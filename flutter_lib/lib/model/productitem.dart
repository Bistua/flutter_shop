

import 'package:json_annotation/json_annotation.dart';
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
/// This allows the `ProductItem` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
///
///在flutter_lib 下使用命令 flutter packages pub run build_runner build
///
///后台监听进程，实时生成.g.dart flutter packages pub run build_runner watch
///
///下面两个报错引用的是  category.g.dart 中生成的代码
///生成category.dart的另一部分 category.g.dart
part 'productitem.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class ProductItem {
  int id;
  String skuId;
  String name;
  String description;
  String metaTitle;
  double price;
  ProductMedias medias;

  ProductItem({
    this.id,
    this.skuId,
    this.name,
    this.description,
    this.metaTitle,
    this.price,
    this.medias,
  });
//  "id": 3,
//  "skuId": 3,
//  "name": "Hoppin' Hot Sauce",
//  "description": "Tangy, ripe cayenne peppes flow together with garlic, onion, tomato paste and a hint of cane sugar to make this a smooth sauce with a bite.  Wonderful on eggs, poultry, pork, or fish, this sauce blends to make rich marinades and soups.",
//  "metaTitle": null,
//  "price": 4.99,
//  "medias": {
//  "alt1": {
//  "id": 302,
//  "url": "/cmsstatic/img/sauces/Hoppin-Hot-Sauce-Close.jpg",
//  "title": "Hoppin Hot Sauce Close-up",
//  "altText": "alt1",
//  "tags": null
//  },
//  "primary": {
//  "id": 301,
//  "url": "/cmsstatic/img/sauces/Hoppin-Hot-Sauce-Bottle.jpg",
//  "title": "Hoppin Hot Sauce Bottle",
//  "altText": "primary",
//  "tags": null
//  }
//  }
//},

  /// A necessary factory constructor for creating a new Category instance
  /// from a map. Pass the map to the generated `_$CategoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case Category.
  ///
  factory ProductItem.fromJson(Map<String, dynamic> json) => _$ProductItemFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$ProductItemToJson(this);

}


/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class ProductMedias {
  Alt alt1;
  Alt primary;

  ProductMedias({
    this.alt1,
    this.primary,
  });



  /// A necessary factory constructor for creating a new Category instance
  /// from a map. Pass the map to the generated `_$CategoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case Category.
  ///
  factory ProductMedias.fromJson(Map<String, dynamic> json) => _$ProductMediasFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$ProductMediasToJson(this);

}



@JsonSerializable()
class Alt{
//  "id": 302,
//  "url": "/cmsstatic/img/sauces/Hoppin-Hot-Sauce-Close.jpg",
//  "title": "Hoppin Hot Sauce Close-up",
//  "altText": "alt1",
//  "tags": null
  int id;
  String url;
  String title;
  String altText;
  String tags;

  Alt({
    this.id,
    this.url,
    this.title,
    this.altText,
    this.tags,

  });
  ///
  factory Alt.fromJson(Map<String, dynamic> json) => _$AltFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$AltToJson(this);

}