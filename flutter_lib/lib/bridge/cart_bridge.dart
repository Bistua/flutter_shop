import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/model/sku.dart';

class CartBridge {
  static const String component = "shop_cart";
  /*
   *
   *获取产品列表
   */
  static Future<Result> addSku(Sku sku) {
    return Bridge.dispenser({
      "method": "add",
      "params": {
        "action": component,
        "arguments": {
          "method": "add",
          "data": {
            "skuId": sku.skuId,
            "amount": sku.amount,
            "price": sku.price,
            "freight": sku.freight
          }
        }
      }
    });
  }

  /*
   *
   *从购物车移除
   */
  static Future<Result> delSku(String skuId, int amount) {
    return Bridge.dispenser({
      "method": "del",
      "params": {
        "action": component,
        "arguments": {
          "method": "del",
          "data": {"skuId": skuId, "amount": amount}
        }
      }
    });
  }

  /*
   *
   *获取购物车信息
   */
  static Future<Result> findCart()  {
    return Bridge.dispenser({
      "method": "findCart",
      "params": {
        "action": component,
        "arguments": {
          "method": "findCart",
        }
      }
    });
  }
}
