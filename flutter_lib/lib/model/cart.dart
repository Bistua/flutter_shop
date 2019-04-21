import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart {
  int totalCounts;
  double totalMoney;
  List<SkuWapper> products;


 Cart({this.totalCounts, this.totalMoney, this.products});



  /// A necessary factory constructor for creating a new Category instance
  /// from a map. Pass the map to the generated `_$CategoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case Category.
  ///
  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$CartToJson(this);
}

//"freight": 0

@JsonSerializable()
class SkuWapper {
  String skuId;
  CartProduct sku;



  SkuWapper({this.skuId, this.sku});


  /// A necessary factory constructor for creating a new Category instance
  /// from a map. Pass the map to the generated `_$CategoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case Category.
  ///
  factory SkuWapper.fromJson(Map<String, dynamic> json) => _$SkuWapperFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$SkuWapperToJson(this);

}


//"skuId": 2001213,
//"amount": 2,
//"price": 37.33,
//"freight": 0

@JsonSerializable()
class CartProduct {
  String skuId;

  int amount;
  double price;
  double freight;
  String norms;
  String name;
  String img;


  CartProduct({this.skuId, this.amount, this.price,this.freight, this.norms,this.name,this.img});


  /// A necessary factory constructor for creating a new Category instance
  /// from a map. Pass the map to the generated `_$CategoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case Category.
  ///
  factory CartProduct.fromJson(Map<String, dynamic> json) => _$CartProductFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$CartProductToJson(this);

}
