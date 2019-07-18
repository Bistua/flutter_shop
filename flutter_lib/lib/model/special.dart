import 'package:json_annotation/json_annotation.dart';

part 'special.g.dart';
//flutter packages pub run build_runner build

@JsonSerializable()
class Special{
  String titleName;//标题
  String specialDesc;//描述
  String productId;//商品ID
  String imgUrl;

  Special(this.titleName, this.specialDesc, this.productId,
      this.imgUrl); //图片url




  factory Special.fromJson(Map<String, dynamic> json) => _$SpecialFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$SpecialToJson(this);

}