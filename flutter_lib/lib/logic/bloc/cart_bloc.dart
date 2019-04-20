import 'dart:async';

import 'package:flutter_lib/bridge/cart_bridge.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/cart.dart';

class CartBloc {
  final cartController = StreamController<Cart>();

  Stream<Cart> get productItems {
    return cartController.stream;
  }

  CartBloc();

  /*
   *
   *添加购物车
   */
  findCart() {
    Future<Result> future =
    CartBridge.findCart();
    future.then((result) {
      if (result.code == 200) {
        Cart categoryList = Cart.fromJson(result.data);
        cartController.add(categoryList);
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }

//  /*
//   *
//   *添加购物车
//   */
//  addSku(int productId, String skuId, int amount, double price, double freight,
//      String norms) {
//    Future<Result> future =
//        CartBridge.addSku(productId, skuId, amount, price, 0, norms);
//    future.then((result) {
//      if (result.code == 200) {
//        Cart categoryList = Cart.fromJson(result.data);
//        cartController.add(categoryList);
//      } else {
//        Bridge.showLongToast(result.msg);
//      }
//    });
//  }
}
