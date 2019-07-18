import 'dart:async' show Future;

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

class CategoryBridge {
  static const String component = "category";
  /*
   *
   *获取产品列表
   */
  static Future<Result> getCategories() async {
    return Bridge.dispenser({
      "method": "root",
      "params": {
        "action": component,
        "arguments": {
          "method": "root",
          "data": {"type": "s"}
        }
      }
    });
  }


  /*
   *
   *获取产品列表
   */
  static Future<Result> getSubCategories( categoryId) async {
    return Bridge.dispenser({
      "method": "sub",
      "params": {
        "action": component,
        "arguments": {
          "method": "sub",
          "data": {"categoryId": categoryId}
        }
      }
    });
  }
}
