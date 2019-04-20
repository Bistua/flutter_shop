import 'dart:async';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/product_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';

import 'package:flutter_lib/model/productitem.dart';
import 'package:flutter_lib/model/productlist.dart';
import 'package:flutter_lib/utils/uidata.dart';

class ProductBloc {
  final ProductViewModel productViewModel = ProductViewModel();
  final productController = StreamController<List<ProductItem>>();

  Stream<List<ProductItem>> get productItems {
    return productController.stream;
  }

  ProductBloc();

  getProducts(int categoryId, bool orderByAes) {
    ProductBridge.getProducts(categoryId, orderByAes).then((result) {
      if (result.code == 200) {
        ProductList productList = ProductList.fromJson(result.data);
        productController.add(productList.list);
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }

  queryProducts(String query, bool orderByAes) {
    ProductBridge.queryProduct(query, orderByAes).then((result) {
      if (result.code == 200) {
        productController.add(null);
        ProductList productList = ProductList.fromJson(result.data);
        productController.add(productList.list);
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }

  getProduct(int productId){
    ProductBridge.getProduct(productId).then((result) {
      if (result.code == 200) {
        ProductList productList = ProductList.fromJson(result.data);
        productController.add(productList.list);
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }
}
