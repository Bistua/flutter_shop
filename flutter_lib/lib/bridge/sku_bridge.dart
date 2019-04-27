import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

class SkuBridge {
  static const String component = "shop_sku";

  /*
  获取商品sku
 */
  static Future<Result> findGoodsSku(String productId) {
    return Bridge.dispenser({
      "method": "find_goods_sku",
      "params": {
        "action": component,
        "arguments": {
          "method": "find_goods_sku",
          "data": {"productId": productId},
        }
      }
    });
  }
}
