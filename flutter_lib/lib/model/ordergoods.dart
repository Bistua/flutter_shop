import 'package:json_annotation/json_annotation.dart';

part 'ordergoods.g.dart';

@JsonSerializable()
class OrderGoods {
  String skuId;
  String buyNum;

  OrderGoods(this.skuId, this.buyNum);

  factory OrderGoods.fromJson(Map<String, dynamic> json) => _$OrderGoodsFromJson(json);

  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$OrderGoodsToJson(this);
}
