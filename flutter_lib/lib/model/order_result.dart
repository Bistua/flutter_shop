import 'package:json_annotation/json_annotation.dart';

part 'order_result.g.dart';

@JsonSerializable()
class OrderResult {
  String tradeOrderId;
  String goodsDesc;
  String attach;

  OrderResult({this.tradeOrderId, this.goodsDesc, this.attach});

  factory OrderResult.fromJson(Map<String, dynamic> json) =>
      _$OrderResultFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResultToJson(this);
}
