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
    return Bridge.dispenser({
      "method": "product_findAll",
      "params": {
        "action": component,
        "arguments": {
          "method": "product_findAll",
          "data": {"categoryId": categoryId, "orderBy": orderBy}
        }
      }
    });
  }

  static distest() {
    ProductViewModel productViewModel = ProductViewModel();
    return productViewModel.getProductItems();
  }

  /*
   *
   *获取产品列表
   */
  static Future<Result> queryProduct(
      String query, bool orderBy, int pageNo, int pageSize) async {
    return Bridge.dispenser({
      "method": "product_search_list",
      "params": {
        "action": component,
        "arguments": {
          "method": "product_search_list",
          "data": {"keywold": query, "pageNo": pageNo, "pageSize": pageSize}
        }
      }
    });
  }

  static Future<Result> getProduct(int productId) async {
    return Bridge.dispenser({
      "method": "product_detail",
      "params": {
        "action": component,
        "arguments": {
          "method": "product_detail",
          "data": {"productId": productId}
        }
      }
    });
  }

  /*
   * 获取feature模块
   */
  static Future<Result> getFeature(int pageNo, int pageSize) async {
    return Bridge.dispenser({
      "method": "product_search_list",
      "params": {
        "action": component,
        "arguments": {
          "method": "product_feature_search",
          "data": {"pageNo": pageNo, "pageSize": pageSize}
        }
      }
    });
  }
}
