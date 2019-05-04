import 'package:json_annotation/json_annotation.dart';
part 'OrderComment.g.dart';
//flutter packages pub run build_runner build
@JsonSerializable()
class OrderComment {
  String orderId;

  List<Goods> goodsEvaluates;

  OrderComment(this.orderId, this.goodsEvaluates);


  /// A necessary factory constructor for creating a new Category instance
  /// from a map. Pass the map to the generated `_$CategoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case Category.
  ///
  factory OrderComment.fromJson(Map<String, dynamic> json) => _$OrderCommentFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$OrderCommentToJson(this);


}

@JsonSerializable()
class Goods {
  String productId;
  String content;
  String level;

  Goods(this.productId, this.content, this.level);

  /// A necessary factory constructor for creating a new Category instance
  /// from a map. Pass the map to the generated `_$CategoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case Category.
  ///
  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$GoodsToJson(this);
}
