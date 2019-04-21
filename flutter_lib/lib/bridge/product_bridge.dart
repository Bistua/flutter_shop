import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';
import 'package:flutter_lib/model/Result.dart';

class ProductBridge {
  static const String component = "product";
  /*
   *
   *获取产品列表
   */
  static Future<Result> getProducts(int categoryId, bool orderBy) async {
    String data = await distest();
    if (data != null) {
      print("bridge result:" + data);
      return Result.fromJson(data);
    }
    return Result.fromJson(json.encode({"code": -1, "msg": "无结果"}));
    //todo 接口通了后使用下面的方法替换上面的假数据
//    return Bridge.dispenser({
//      "method": "getProducts",
//      "params": {
//        "action": component,
//        "arguments": {
//          "method": "getProducts",
//          "data": {"categoryId": categoryId,"orderBy":orderBy}
//        }
//      }
//    });
  }

  static distest() {
    ProductViewModel productViewModel = ProductViewModel();
    return productViewModel.getProductItems();
  }

  /*
   *
   *获取产品列表
   */
  static Future<Result> queryProduct(String query, bool orderBy) async {
    String data = await distest();
    if (data != null) {
      print("bridge result:" + data);
      return Result.fromJson(data);
    }
    return Result.fromJson(json.encode({"code": -1, "msg": "无结果"}));
    //todo 接口通了后使用下面的方法替换上面的假数据
//    return Bridge.dispenser({
//      "method": "queryProduct",
//      "params": {
//        "action": component,
//        "arguments": {
//          "method": "queryProduct",
//          "data": {"query": query,"orderBy":orderBy}
//        }
//      }
//    });
  }

  static Future<Result> getProduct(int productId) async {
    String data = await distest();
    if (data != null) {
      print("bridge result:" + data);
      return Result.fromJson(data);
    }
//
//    return Bridge.dispenser({
//      "method": "detail",
//      "params": {
//        "action": component,
//        "arguments": {
//          "method": "detail",
//          "data": {"productId": productId}
//        }
//      }
//    });
  }
}
