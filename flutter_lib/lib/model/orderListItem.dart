import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderListItem.g.dart';

@JsonSerializable()
class OrderItem {
//  //1:待付款，2:待发货，3:待收货，4:待评价,0:全部
  int status;
  Address address; //收货地址
  String express; //最新一条物流信息
  @JsonKey(name: 'goodsList')
  List<Good> products; //商品信息
  @JsonKey(name: 'orderId')
  String orderNumber; //订单编号
  String orderTime; //下单时间
  String payMode; //支付方式
  double productTotal; //商品合计(价格)
  double freight; //运费
  @JsonKey(name: 'buyAllPrice')
  String payPrice; //实付款

  OrderItem(
      {this.status,
      this.address,
      this.express,
      this.products, //商品信息

      this.orderNumber, //订单编号
      this.orderTime, //下单时间
      this.payMode, //支付方式
      this.productTotal, //商品合计(价格)
      this.freight, //运费
      this.payPrice});

  /// A necessary factory constructor for creating a new Category instance
  /// from a map. Pass the map to the generated `_$CategoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case Category.
  ///
  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}


@JsonSerializable()
class Good {
  String buyNum;
  String goodsId;
  String goodsName;
  String goodsPrice;
  String goodsImgUrl;
  String specMsg;
  Good({
    this.buyNum,
    this.goodsId,
    this.goodsName,
    this.goodsPrice, //商品信息
    this.specMsg,
  });

  factory Good.fromJson(Map<String, dynamic> json) =>
      _$GoodFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$GoodToJson(this);
}
