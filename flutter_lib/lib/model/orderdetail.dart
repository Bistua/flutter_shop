import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/order_bridge.dart';
import 'package:flutter_lib/model/OrderComment.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/model/orderListItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orderdetail.g.dart';

//{createTime: 2019-04-30 16:46:33,
// freight: 0,
// goods: [{allGoodsPrice: 1,
// buyNum: 1,
// goodsId: 100,
// goodsName: Hawt Like a Habanero Shirt (Men's),
// goodsPrice: 1,
// specMsg: SIZE:S}],
// orderId: 1556642793767000,
// orderPrice: 1,
// payFee: 0, payType: 0,
// receiveGoods: {
// receiveAddressName: 上海,
// receiveGoodsName: 一明,
// receivePhone: 18612341234,
// status: 0,
// userAddressId:
// 1556616203528004},
// status: 0}

//flutter packages pub run build_runner build
@JsonSerializable()
class OrderDetail {
  String orderId; //订单编号
  int status; //状态 1:待付款，2:待发货，3:待收货，4:待评价，5：完成，6：已取消
  Address receiveGoods; //收货地址
  String express; //最新一条物流信息

  List<Good> goods; //商品信息
  String createTime; //下单时间

  String payType; //支付方式
  String orderPrice; //订单金额
  String freight; //运费
  String payFee;


  OrderDetail.O(this.orderId);

  OrderDetail(
      this.orderId,
      this.status,
      this.receiveGoods,
      this.express,
      this.goods,
      this.createTime,
      this.payType,
      this.orderPrice,
      this.freight,
      this.payFee); //实付款

  factory OrderDetail.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);

  String getStatusName() {
    switch (status) {
      case 0:
        return "已取消";
      case 1:
        return "待付款";
      case 2:
        return "待发货";
      case 3:
        return "待收货";
      case 4:
        return "待评价";
      default:
        return "";
    }
  }
//  1:待付款，2:待发货，3:待收货，4:待评价,0:全部
  String getListStatusName() {
    switch (status) {
      case 0:
        return "已取消";
      case 1:
        return "待付款";
      case 2:
        return "待发货";
      case 3:
        return "待收货";
      case 4:
        return "待评价";
      default:
        return "";
    }
  }

  String getStatusButtonName() {
    switch (status) {
      case 0:
        return "已取消";
      case 1:
        return "取消订单";
      case 2:
        return "查看物流";
      case 3:
        return "申请售后";
      case 4:
        return "申请售后";
      default:
        return "";
    }
  }

  doWithOrder(){
    switch (status) {
      case 0:
        Future<Result> future =
        OrderBridge.cancelOrder(orderId);
        future.then((r) {
          if (r.code == 200) {
            Bridge.showLongToast("取消成功");
          } else {
            Bridge.showLongToast(r.msg);
          }
        });
        break;
      case 2:

        Bridge.webview("https://www.kuaidi100.com/chaxun?com=[]&nu=[]");
        break;
      case 3:
        Bridge.webview("https://www.kuaidi100.com/chaxun?com=[]&nu=[]");
        break;
      case 4:
        Bridge.webview("https://www.kuaidi100.com/chaxun?com=[]&nu=[]");
        break;
      default:
        return "";
    }
  }
}
//
//@JsonSerializable()
//class Goods {
//  String goodsName;
//  String goodsPrice;
//  String buyNum;
//  String allGoodsPrice;
//  String goodsImgUrl;
//  String goodsId;
//  String specMsg;
//
//  Goods(this.goodsName, this.goodsPrice, this.buyNum, this.allGoodsPrice,
//      this.goodsImgUrl, this.goodsId, this.specMsg);
//
//  factory Goods.fromJson(Map<String, dynamic> json) => _$GoodsFromJson(json);
//
//  /// `toJson` is the convention for a class to declare support for serialization
//  /// to JSON. The implementation simply calls the private, generated
//  /// helper method `_$CategoryToJson`.
//  Map<String, dynamic> toJson() => _$GoodsToJson(this);
//}
