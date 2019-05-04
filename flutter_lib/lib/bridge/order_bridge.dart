import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/OrderComment.dart';
import 'package:flutter_lib/model/Result.dart';

class OrderBridge {
  static const String component = "order";
  /*
   *
   *获取产品列表
   */
  static Future<Result> submitOrder(
      String userAddressId, bool freight, dynamic orderGoods) async {
//    String data = await CategoryViewModel.distest();
//    if (data != null) {
//      print("bridge result:" + data);
//      return Result.fromJson(data);
//    }
//    return Result.fromJson(json.encode({"code": -1, "msg": "无结果"}));
  print(orderGoods);
  print(json.encode(orderGoods));
    return Bridge.dispenser({
      "method": "order_submit",
      "params": {
        "action": component,
        "arguments": {
          "method": "order_submit",
          "data": {
            "userAddressId": userAddressId,
            "freight": freight ? "1" : "",
            "goods": json.encode(orderGoods)
          }
        }
      }
    });
  }

  static Future<Result> cancelOrder(String orderId) async {
    return Bridge.dispenser({
      "method": "order_cancel",
      "params": {
        "action": component,
        "arguments": {
          "method": "order_cancel",
          "data": {
            "orderId": orderId,
          }
        }
      }
    });
  }


  static Future<Result> confirmOrder(String orderId) async {
    return Bridge.dispenser({
      "method": "order_confirm",
      "params": {
        "action": component,
        "arguments": {
          "method": "order_confirm",
          "data": {
            "orderId": orderId,
          }
        }
      }
    });
  }

  static Future<Result> submitComment(OrderComment order) async {
    return Bridge.dispenser({
      "method": "order_comment",
      "params": {
        "action": component,
        "arguments": {
          "method": "order_comment",
          "data": json.encode(order),
        }
      }
    });
  }


}
