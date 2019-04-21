import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

class AddressBridge {
  static const String component = "address";

  /*
  新增地址
  receivePhone;//手机号
  receiveGoodsName;//姓名
  receiveAddressName;//地址信息
  status;//状态 1：默认，0：非默认
 */
  static Future<Result> addAddress(String receivePhone, String receiveGoodsName,
      String receiveAddressName, int status) {
    return Bridge.dispenser({
      "method": "add",
      "params": {
        "action": component,
        "arguments": {
          "method": "add",
          "data": {
            "receivePhone": receivePhone,
            "receiveGoodsName": receiveGoodsName,
            "receiveAddressName": receiveAddressName,
            "status": status
          },
        }
      }
    });
  }
}
