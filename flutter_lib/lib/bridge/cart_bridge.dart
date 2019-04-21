import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

class CartBridge {
  static const String component = "shop_cart";

  /*
   *
   *添加购物车
   */
  static Future<Result> addSku(
      int productId,
      String skuId,
      int amount,
      double price,
      double freight,
      String norms,
      String name,
      String url) async {
    //todo  "data": json.encode 待测试
    String data = await getCart();
    return Result.fromJson(data);
//    return Bridge.dispenser({
//      "method": "add",
//      "params": {
//        "action": component,
//        "arguments": {
//          "method": "add",
//          "data": json.encode({
//            "productId": productId,
//            "skuId": skuId,
//            "amount": amount,
//            "price": price,
//            "freight": freight,
//            "norms": norms,
//            "name": name,
//            "img": url,
//          }),
//        },
//      }
//    });
  }

  static getCart() async {
    return json.encode({
      "code": 200,
      "msg": "s",
      "data": {
        "products": [
          {
            "sku": {
              "amount": 1,
              "freight": 0.0,
              "img":
                  "https://gd1.alicdn.com/imgextra/i4/842112630/TB2HDRvjb1YBuNjSszeXXablFXa_!!842112630.jpg",
              "name": "Hoppin' Hot Sauce",
              "price": 4.99,
              "productId": "3",
              "skuId": "3"
            },
            "skuId": "3"
          },
          {
            "sku": {
              "amount": 1,
              "freight": 0.0,
              "img":
              "https://gd2.alicdn.com/imgextra/i2/2873137436/TB2gX2DrDmWBKNjSZFBXXXxUFXa_!!2873137436.png_400x400.jpg",
              "name": "Hoppin' Hot Sauce",
              "price": 4.99,
              "productId": "3",
              "skuId": "3"
            },
            "skuId": "5"
          }
        ],
        "totalCounts": 10,
        "totalMoney": 10.0
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
  static Future<Result> findCart() async {
    return  Result.fromJson( await getCart());
//
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
