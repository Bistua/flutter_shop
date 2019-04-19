import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/sku.dart';

class ProductBridge {
  static const String component = "product";
  /*
   *
   *获取产品列表
   */
  static Future<Result> getProducts(String type,bool orderBy)async {
    String data =  await distest();
    if (data != null) {
      print("bridge result:"+data);
      return Result.fromJson(data);
    }
    return Result.fromJson(json.encode({"code": -1, "msg": "无结果"}));
//    return Bridge.dispenser({
//      "method": "getProducts",
//      "params": {
//        "action": component,
//        "arguments": {
//          "method": "getProducts",
//          "data": {"type": type,"orderBy":orderBy}
//        }
//      }
//    });
  }

  static distest() {
    ProductViewModel productViewModel = ProductViewModel();
    return json.encode({"code": 200});

  }



  /*
   *
   *创建订单
   */
  static Future<Result> newOrder(List<Sku> sku) {
    return Bridge.dispenser({
      "method": "newOrder",
      "params": {
        "action": component,
        "arguments": {
          "method": "newOrder",
          "data": {"type": json.encode(sku)}
        }
      }
    });
  }

}
