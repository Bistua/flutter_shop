import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

class EvaluateBridge {
  static const String component = "evaluate";

  /*
  评价商品
 */
  static Future<Result> goodsEvaluate(
      String goodsId, String content, String level) {
    return Bridge.dispenser({
      "method": "goods_evaluate",
      "params": {
        "action": component,
        "arguments": {
          "method": "goods_evaluate",
          "data": {"goodsId": goodsId, "content": content, "level": level},
        }
      }
    });
  }

  /*
  获取所有评价
 */
  static Future<Result> allEvaluate(String goodsId, int pageNo, int pageSize) {
    return Bridge.dispenser({
      "method": "all_evaluate",
      "params": {
        "action": component,
        "arguments": {
          "method": "all_evaluate",
          "data": {"goodsId": goodsId, "pageNo": pageNo, "pageSize": pageSize},
        }
      }
    });
  }
}
