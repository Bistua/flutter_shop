import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

class RebateBridge {
  static const String component = "rebate";

  /*
  获取返现统计列表
 */
  static Future<Result> findRebateList(int pageNo, int pageSize) {
    return Bridge.dispenser({
      "method": "rebate_findIntegral",
      "params": {
        "action": component,
        "arguments": {
          "method": "rebate_findIntegral",
          "data": {"pageNo": pageNo, "pageSize": pageSize},
        }
      }
    });
  }

  /*
  获取当前用户的消费详情记录
 */
  static Future<Result> findRebateDetail(int pageNo, int pageSize) {
    return Bridge.dispenser({
      "method": "rebate_consume",
      "params": {
        "action": component,
        "arguments": {
          "method": "rebate_consume",
          "data": {"pageNo": pageNo, "pageSize": pageSize},
        }
      }
    });
  }
}
