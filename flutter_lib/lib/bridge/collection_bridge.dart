import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

class CollectionBridge {
  static const String component = "collection";

  /*
  收藏商品
 */
  static Future<Result> goodsCollection(String goodsId) {
    return Bridge.dispenser({
      "method": "goods_collection",
      "params": {
        "action": component,
        "arguments": {
          "method": "goods_collection",
          "data": {"goodsId": goodsId},
        }
      }
    });
  }

  /*
  获取所有收藏
 */
  static Future<Result> allCollection(int pageNo, int pageSize) {
    return Bridge.dispenser({
      "method": "all_collection",
      "params": {
        "action": component,
        "arguments": {
          "method": "all_collection",
          "data": {"pageNo": pageNo, "pageSize": pageSize},
        }
      }
    });
  }
}
