import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/order_bridge.dart';
import 'package:flutter_lib/bridge/order_list_bridge.dart';
import 'package:flutter_lib/model/orderListItem.dart';
import 'package:flutter_lib/model/orderdetail.dart';
import 'package:flutter_lib/model/orderlist.dart';
import 'package:flutter_lib/utils/BristuaRouter.dart';

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

  getOrderListList(BuildContext context, int type) {
    OrderListBridge.getOrderList(1, 50, type).then((result) {
      if (result.code == 200) {
        OrderList orderList = OrderList.fromJson(result.data);
        orderListController.add(orderList.list);
      } else {
        print(result.msg == null ? "未返回错误信息" : result.msg);
        if (result.code == 401) {
          //此处需要判断啊，不要认为很简单的
          //Navigator.pushNamed(context, UIData.login);
          //
          BristuaRouter.routerUserLogin(context);
        }
        orderListController.addError(result);
      }
    });
  }

  getOrderDetail(String orderId) {
    OrderBridge.orderDetail(orderId).then((result) {
      if (result.code == 200) {
        OrderDetail orderDetail = OrderDetail.fromJson(result.data);
        orderDetailController.add(orderDetail);
      } else {
        print(result.msg == null ? "未返回错误信息" : result.msg);
        orderDetailController.addError(result);
      }
    });
  }

  void close() {
    orderListController?.close();
  }
}
