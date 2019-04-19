import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
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
    String data = await distest();
    if (data != null) {
      print("bridge result:" + data);
      return Result.fromJson(data);
    }
    return Result.fromJson(json.encode({"code": -1, "msg": "无结果"}));
    //todo 接口通了后使用下面的方法替换上面的假数据
//    return Bridge.dispenser({
//      "method": "getCategory",
//      "params": {
//        "action": component,
//        "arguments": {
//          "method": "category",
//          "data": {"type": type,"orderBy":orderBy}
//        }
//      }
//    });
  }

  static distest() {
    ProductViewModel productViewModel = ProductViewModel();
    return json.encode({"code": 200});
  }
}
