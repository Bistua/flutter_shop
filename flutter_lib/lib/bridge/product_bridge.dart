import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/sku.dart';

class ProductBridge {
  static const String component = "product";
  /*
   *
   *获取产品列表
   */
  static Future<Result> getProducts(String type) {
    return Bridge.dispenser({
      "method": "getProducts",
      "params": {
        "action": component,
        "arguments": {
          "method": "getProducts",
          "data": {"type": type}
        }
      }
    });
  }



  /*
   *
   *创建订单
   */
  static Future<Result> newOrder(List<Sku> sku) {
    return Bridge.dispenser({
      "method": "newOrder",
      "params": {
        "action": component,
        "arguments": {
          "method": "newOrder",
          "data": {"type": json.encode(sku)}
        }
      }
    });
  }

}
