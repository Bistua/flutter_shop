import 'dart:async';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/order_bridge.dart';
import 'package:flutter_lib/bridge/order_list_bridge.dart';
import 'package:flutter_lib/model/orderdetail.dart';
import 'package:flutter_lib/model/orderListItem.dart';
import 'package:flutter_lib/model/orderlist.dart';

class OrderListBloc {
  final orderListController = StreamController<List<OrderItem>>.broadcast();

  Stream<List<OrderItem>> get productItems {
    return orderListController.stream;
  }


  final orderDetailController = StreamController<OrderDetail>.broadcast();

  Stream<OrderDetail> get orderDetail {
    return orderDetailController.stream;
  }



  OrderListBloc();

  getOrderListList(int type) {
    OrderListBridge.getOrderList(1, 50, type).then((result) {
      if (result.code == 200) {
        OrderList orderList = OrderList.fromJson(result.data);
        orderListController.add(orderList.list);
      } else {
        Bridge.showLongToast(result.msg == null ? "未返回错误信息" : result.msg);
        orderListController.add(List());
      }
    });
  }


  getOrderDetail(String orderId) {
    OrderBridge.orderDetail(orderId).then((result) {
      if (result.code == 200) {
        OrderDetail orderDetail = OrderDetail.fromJson(result.data);
        orderDetailController.add(orderDetail);
      } else {
        Bridge.showLongToast(result.msg == null ? "未返回错误信息" : result.msg);
        orderDetailController.add(null);
      }
    });
  }
}
