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
      "method": "address_add",
      "params": {
        "action": component,
        "arguments": {
          "method": "address_add",
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
