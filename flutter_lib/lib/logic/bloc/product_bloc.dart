import 'dart:async';
import 'dart:convert';
import 'package:flutter_lib/bridge/product_bridge.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';

class ProductBloc {
  final ProductViewModel productViewModel = ProductViewModel();
  final productController = StreamController<List<Product>>();
  Stream<List<Product>> get productItems {
    return productController.stream;
  }

  ProductBloc();

  getProduct(String type, bool orderByAes) {
    ProductBridge.getProducts("1", orderByAes).then((result) {
//      if (result.code == 200) {
        //todo 解析商品data 然后productController.add
        productViewModel.productsItems = productViewModel.getProductTests();

        productController.add(productViewModel.productsItems);
//      }
    });
  }
}
