import 'dart:async';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/product_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/utils/uidata.dart';

class ProductBloc {
  final ProductViewModel productViewModel = ProductViewModel();
  final productController = StreamController<List<Product>>();

  Stream<List<Product>> get productItems {
    return productController.stream;
  }

  ProductBloc();

  getProduct(int categoryId, bool orderByAes) {
    ProductBridge.getProducts(categoryId, orderByAes).then((result) {
      if (result.code == 200) {
        //todo 解析data

        productController.add(null);
        if (orderByAes) {
          print("点击回调 getProduct：" + orderByAes.toString());
          productViewModel.productsItems = productViewModel.getProduct1Tests();
        } else {
          print("点击回调 getProduct：" + orderByAes.toString());
          productViewModel.productsItems = productViewModel.getProductTests();
        }

        //然后add  每次add相当于发送了一次事件

        productController.add(productViewModel.productsItems);
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }

  queryProduct(String query, bool orderByAes) {
    ProductBridge.queryProduct(query, orderByAes).then((result) {
      if (result.code == 200) {
        //todo 解析data

        productController.add(null);
        if (orderByAes) {
          print("点击回调 getProduct：" + orderByAes.toString());
          productViewModel.productsItems = productViewModel.getProduct1Tests();
        } else {
          print("点击回调 getProduct：" + orderByAes.toString());
          productViewModel.productsItems = productViewModel.getProductTests();
        }

        //然后add  每次add相当于发送了一次事件

        productController.add(productViewModel.productsItems);
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }
}
