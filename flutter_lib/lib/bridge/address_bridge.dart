import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/address.dart';

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
    Address adss = new Address();
    adss.phone = receivePhone;
    adss.name = receiveGoodsName;
    adss.address = receiveAddressName;
    adss.status = status;

    return Bridge.dispenser({
      "method": "address_add",
      "params": {
        "action": component,
        "arguments": {
          "method": "address_add",
          "data": json.encode(adss),
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
