import 'dart:async';

import 'package:flutter_lib/bridge/product_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductBloc {
  final ProductViewModel productViewModel = ProductViewModel();
  final productController = StreamController<List<Product>>();

  Stream<List<Product>> get productItems {
    return productController.stream;
  }

  ProductBloc();

  getProduct(String type, bool orderByAes) {
    ProductBridge.getProducts("1", orderByAes).then((result) {
      if (result.code == 200) {
        //todo 解析data
        productViewModel.productsItems = productViewModel.getProductTests();
        //然后add  每次add相当于发送了一次事件
        productController.add(productViewModel.productsItems);
      } else {
        Fluttertoast.showToast(
            msg: result.msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            textColor: UIData.fffa4848,
            backgroundColor: UIData.fffa4848,
            fontSize: 16.0);
      }
    });
  }
}
