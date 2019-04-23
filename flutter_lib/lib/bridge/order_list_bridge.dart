import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

class OrderListBridge {
  static const String component = "orderlist";

  /*
  获取订单列表
 orderType 1:待付款，2:待发货，3:待收货，4:待评价,0:全部
 */
  static Future<Result> getOrderList(int pageNo, int pageSize, int orderType) {
    return Bridge.dispenser({
      "method": "orderlist_findall",
      "params": {
        "action": component,
        "arguments": {
          "method": "orderlist_findall",
          "data": {
            "pageNo": pageNo,
            "pageSize": pageSize,
            "orderType": orderType,
          },
        }
      }
    });
  }

  /*
  获取地址
 */
  static Future<Result> findAddress(int pageNo, int pageSize) {
    return Bridge.dispenser({
      "method": "address_find",
      "params": {
        "action": component,
        "arguments": {
          "method": "address_find",
          "data": {"pageNo": pageNo, "pageSize": pageSize},
        }
      }
    });
  }
}
