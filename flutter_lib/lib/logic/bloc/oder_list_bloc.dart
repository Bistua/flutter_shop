import 'dart:async';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/order_list_bridge.dart';
import 'package:flutter_lib/model/orderListItem.dart';
import 'package:flutter_lib/model/orderlist.dart';

class OrderListBloc {
  final orderListController = StreamController<List<OrderItem>>();

  Stream<List<OrderItem>> get productItems {
    return orderListController.stream;
  }

  OrderListBloc();

  getOrderListList(int type) {
    OrderListBridge.getOrderList(1, 2000, type).then((result) {
      if (result.code == 200) {
        OrderList orderList = OrderList.fromJson(result.data);
        orderListController.add(orderList.list);
      } else {
        Bridge.showLongToast(result.msg == null ? "未返回错误信息" : result.msg);
        orderListController.add(List());
      }
    });
  }
}
