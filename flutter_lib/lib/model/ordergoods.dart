import 'package:json_annotation/json_annotation.dart';

part 'ordergoods.g.dart';

@JsonSerializable()
class OrderGoods {
  String goodsId;
  String buyNum;
  String productId;



  OrderGoods(this.goodsId, this.buyNum, this.productId);

  factory OrderGoods.fromJson(Map<String, dynamic> json) => _$OrderGoodsFromJson(json);

  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$OrderGoodsToJson(this);
}
