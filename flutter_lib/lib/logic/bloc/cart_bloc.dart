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

  addSku(int productId, String skuId, int amount, double price, double freight,
      String norms, String name, String url) async {
    Future<Result> future = CartBridge.addSku(
        productId, skuId, amount, price, freight, norms, name, url);
    future.then((result) {
      if (result.code == 200) {
        Cart categoryList = Cart.fromJson(result.data);
        cartController.add(categoryList);
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }

  findCart() {
    Future<Result> future = CartBridge.findCart();
    future.then((result) {
      if (result.code == 200) {
        Cart categoryList = Cart.fromJson(result.data);
        cartController.add(categoryList);
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }

  del2Cart(SkuWapper sku, int amount) {
    Future<Result> future =
        CartBridge.delSku(sku.sku.productId, sku.skuId, amount);
    future.then((result) {
      if (result.code == 200) {
        Cart categoryList = Cart.fromJson(result.data);
        cartController.add(categoryList);
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }

  addSkuAmount(SkuWapper sku, int amount) {
    Future<Result> future =
        CartBridge.delSku(sku.sku.productId, sku.skuId, amount);
    future.then((result) {
      if (result.code == 200) {
        Cart categoryList = Cart.fromJson(result.data);
        cartController.add(categoryList);
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }
}