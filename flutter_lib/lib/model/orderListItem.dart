import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/model/product.dart';

class OrderItem {
  int status; //状态 0已取消，1等待发货，2已发货，3已收货，4完成交易
  Address address; //收货地址
  String express; //最新一条物流信息
  List<Product> products; //商品信息
  String orderNumber; //订单编号
  String orderTime; //下单时间
  String payMode; //支付方式
  double productTotal; //商品合计(价格)
  double freight; //运费
  double payPrice; //实付款


  OrderItem(
      {this.status,
        this.address,
        this.express,
        this.products,//商品信息
        this. orderNumber, //订单编号
        this. orderTime, //下单时间
        this. payMode, //支付方式
        this. productTotal, //商品合计(价格)
        this. freight, //运费
        this. payPrice});


}
