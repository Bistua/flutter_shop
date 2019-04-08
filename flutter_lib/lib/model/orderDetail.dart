import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/model/product.dart';

class OrderDetail {
  int status; //状态 0已取消，1等待发货，2已发货，3已收货，4交易完成
  Address address; //收货地址
  String express; //最新一条物流信息
  List<Product> products; //商品信息
  String orderNumber; //订单编号
  String orderTime; //下单时间
  String payMode; //支付方式
  double productTotal; //商品合计(价格)
  double freight; //运费
  double payPrice; //实付款

  String getStatusName(){
    switch(status){
      case 0:
        return "已取消";
      case 1:
        return "等待发货";
      case 2:
        return "已发货";
      case 3:
        return "已收货";
      case 4:
        return "交易完成";
    }
  }

  String getListStatusName(){
    switch(status){
      case 0:
        return "已取消";
      case 1:
        return "待发货";
      case 2:
        return "已发货";
      case 3:
        return "待评价";
      case 4:
        return "待评价";
    }
  }

  String getStatusButtonName(){
    switch(status){
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
    }
  }

  String getListStatusButtonName(){
    switch(status){
      case 0:
        return "已取消";
      case 1:
        return "取消订单";
      case 2:
        return "查看物流";
      case 3:
        return "退换货";
      case 4:
        return "退换货";
    }
  }
}
