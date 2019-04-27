import 'dart:typed_data';

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

/*
  根据属性组合获取具体的sku信息
 */
  static Future<Result> findGoodsSkuInfo(
      String productId, Int64List optionsIds) {
    return Bridge.dispenser({
      "method": "find_goods_sku_info",
      "params": {
        "action": component,
        "arguments": {
          "method": "find_goods_sku_info",
          "data": {"productId": productId, "optionsIds": optionsIds},
        }
      }
    });
  }
}
