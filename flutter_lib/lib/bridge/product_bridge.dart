import 'package:flutter_lib/bridge.dart';

class ProductBridge {
  /*
   *
   *获取产品列表
   */
  static Future<String> getProducts(String type) {
    return Bridge.dispenser({
      "method": "getProducts",
      "params": {
        "action": "getProducts",
        "data": {"type": type}
      }
    });
  }
}
