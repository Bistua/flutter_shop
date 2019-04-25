import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

class InfoBridge {
  static const String component = "user_info";

  /*
  微信登录
  tradeOrderId;//交易订单号
  spbillCreateIp;//终商IP
  goodsDesc;//商品描述
  tradeType;//交易类型
  attach;//附加数据，在查询API和支付通知中原样返回，该字段主要用于商户携带订单的自定义数据
 */
  static Future<Result> wxInfo() {
    return Bridge.dispenser({
      "method": "user_wx_info",
      "params": {
        "action": component,
        "arguments": {
          "method": "user_wx_info",
          "data": {},
        }
      }
    });
  }
}
