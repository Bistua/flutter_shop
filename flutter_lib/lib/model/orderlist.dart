import 'package:flutter_lib/model/orderListItem.dart';

class OrderList {
  List<OrderItem> list;

  OrderList({this.list});

  factory OrderList.fromJson(dynamic result) {
    print("OrderList");
    print(result);
    List<dynamic> parsedJson = result["list"];
    var list = parsedJson.map((i) => OrderItem.fromJson(i)).toList();
    return new OrderList(
      list: list,
    );
  }
}
