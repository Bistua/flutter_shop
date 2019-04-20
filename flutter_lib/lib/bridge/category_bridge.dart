import 'dart:async' show Future;
import 'dart:convert';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/category_view_model.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/sku.dart';
class CategoryBridge {
  static const String component = "category";
  /*
   *
   *获取产品列表
   */
  static Future<Result> getCategories() async {
//    String data = await distest();
//    if (data != null) {
//      print("bridge result:" + data);
//      return Result.fromJson(data);
//    }
//    return Result.fromJson(json.encode({"code": -1, "msg": "无结果"}));
//    todo 接口通了后使用下面的方法替换上面的假数据
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

  static distest() {
    CategoryViewModel productViewModel = CategoryViewModel();




    return {"code": 200,"data":jsonEncode(productViewModel.getCategory()),"msg":"success"};
  }
  /*
   *
   *获取产品列表
   */
  static Future<Result> getSubCategories(int categoryId) async {
//    String data = await distest();
//    if (data != null) {
//      print("bridge result:" + data);
//      return Result.fromJson(data);
//    }
//    return Result.fromJson(json.encode({"code": -1, "msg": "无结果"}));
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
