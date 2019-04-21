import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/category_view_model.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/ordergoods.dart';

class OrderBridge {
  static const String component = "order";
  /*
   *
   *获取产品列表
   */
  static Future<Result> submitOrder(
      String userAddressId, bool freight, List<OrderGoods> orderGoods) async {
//    String data = await CategoryViewModel.distest();
//    if (data != null) {
//      print("bridge result:" + data);
//      return Result.fromJson(data);
//    }
//    return Result.fromJson(json.encode({"code": -1, "msg": "无结果"}));
    return Bridge.dispenser({
      "method": "submit",
      "params": {
        "action": component,
        "arguments": {
          "method": "submit",
          "data": {
            "userAddressId": userAddressId,
            "freight": freight ? "1" : "",
            "data": json.encode(orderGoods)
          }
        }
      }
    });
  }
}
