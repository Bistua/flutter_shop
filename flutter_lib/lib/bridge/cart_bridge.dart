import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

class CartBridge {
  static const String component = "shop_cart";

  /*
   *
   *添加购物车
   */
  static Future<Result> addSku(int productId, String skuId, int amount,
      double price, double freight, String norms, String name, String url) {
    return Bridge.dispenser({
      "method": "add",
      "params": {
        "action": component,
        "arguments": {
          "method": "add",
          "data": json.encode({
            "productId": productId,
            "skuId": skuId,
            "amount": amount,
            "price": price,
            "freight": freight,
            "norms": norms,
            "name": name,
            "img": url,
          }),
        },
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

  static getcarts() {
    return json.encode({
      "code": 200,
      "msg": null,
      "data": [
        {
          "totalCounts": 10,
          " totalMoney": 1000.12,
          "products": [
            {
              "skuId": 2001213,
              "amount": 2,
              "price": 37.33,
              "freight": 0,
              "name": "test",
              "img": "图片地址",
            },
            {
              "skuId": 2001213,
              "amount": 2,
              "price": 37.33,
              "freight": 0,
              "name": "test",
              "img": "图片地址",
            },
            {
              "skuId": 2001213,
              "amount": 2,
              "price": 37.33,
              "freight": 0,
              "name": "test",
              "img": "图片地址",
            },
            {
              "skuId": 2001213,
              "amount": 2,
              "price": 37.33,
              "freight": 0,
              "name": "test",
              "img": "图片地址",
            }
          ]
        }
      ]
    });
  }

  /*
   *
   *获取购物车信息
   */
  static Future<Result> findCart() async {
    return await getcarts();

//    return Bridge.dispenser({
//      "method": "findCart",
//      "params": {
//        "action": component,
//        "arguments": {
//          "method": "findCart",
//        }
//      }
//    });
  }
}
