import 'package:flutter_lib/bridge.dart';

class ProductBridge {
  static const String component = "product";
  /*
   *
   *获取产品列表
   */
  static Future<String> getProducts(String type) {
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
}
