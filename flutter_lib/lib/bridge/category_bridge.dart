import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/category_view_model.dart';
import 'package:flutter_lib/model/Result.dart';

class CategoryBridge {
  static const String component = "category";
  /*
   *
   *获取产品列表
   */
  static Future<Result> getCategories() async {
    String data = await CategoryViewModel.distest();
    if (data != null) {
      print("bridge result:" + data);
      return Result.fromJson(data);
    }
    return Result.fromJson(json.encode({"code": -1, "msg": "无结果"}));
//    todo 接口通了后使用下面的方法替换上面的假数据
//    return Bridge.dispenser({
//      "method": "root",
//      "params": {
//        "action": component,
//        "arguments": {
//          "method": "root",
//          "data": {"type": "s"}
//        }
//      }
//    });
  }


  /*
   *
   *获取产品列表
   */
  static Future<Result> getSubCategories(int categoryId) async {
    String data = await CategoryViewModel.distest1();
    if (data != null) {
      print("bridge result:" + data);
      return Result.fromJson(data);
    }
    return Result.fromJson(json.encode({"code": -1, "msg": "无结果"}));
//    return Bridge.dispenser({
//      "method": "sub",
//      "params": {
//        "action": component,
//        "arguments": {
//          "method": "sub",
//          "data": {"categoryId": categoryId}
//        }
//      }
//    });
  }
}
