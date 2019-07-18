import 'package:json_annotation/json_annotation.dart';

part 'promotion.g.dart';
//flutter packages pub run build_runner build

@JsonSerializable()
class Promotion{
  String promotionTitle;
  String promotionDesc;
  String productId;
  String sellPrice;
  String promotionPrice;
  String imgUrl;

  Promotion(this.promotionTitle, this.promotionDesc, this.productId,
      this.sellPrice, this.promotionPrice, this.imgUrl);


  factory Promotion.fromJson(Map<String, dynamic> json) => _$PromotionFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$PromotionToJson(this);

}