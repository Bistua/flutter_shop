import 'package:json_annotation/json_annotation.dart';

part 'order_result.g.dart';

@JsonSerializable()
class OrderResult {
  String orderId;

  OrderResult({this.orderId});

  factory OrderResult.fromJson(Map<String, dynamic> json) =>
      _$OrderResultFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResultToJson(this);


}
