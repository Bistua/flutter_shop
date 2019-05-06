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
        cartController.add(null);
        print(result.msg == null ? "未返回错误信息" : result.msg);
      }
    });
  }

  findCart() {
    Future<Result> future = CartBridge.findCart();
    future.then((result) {
      if (result.code == 200) {
        if (result.data != null && result.data is Map<String, dynamic>) {
          Cart categoryList = Cart.fromJson(result.data);
          cartController.add(categoryList);
        } else {
          Cart categoryList = new Cart(totalCounts: 0);
          cartController.add(categoryList);
        }
      } else {
        cartController.add(Cart());
        print(result.msg == null ? "未返回错误信息" : result.msg);
      }
    });
  }

  del2Cart(SkuWapper sku, int amount) {
    Future<Result> future =
        CartBridge.delSku(sku.sku.productId, sku.goodsId, amount);
    future.then((result) {
      if (result.code == 200) {
        Cart categoryList = Cart.fromJson(result.data);
        cartController.add(categoryList);
      } else {
        print(result.msg == null ? "未返回错误信息" : result.msg);
      }
    });
  }

  addSkuAmount(SkuWapper sku, int amount) {
    Future<Result> future =
        CartBridge.delSku(sku.sku.productId, sku.goodsId, amount);
    future.then((result) {
      if (result.code == 200) {
        Cart categoryList = Cart.fromJson(result.data);
        cartController.add(categoryList);
      } else {
        print(result.msg == null ? "未返回错误信息" : result.msg);
      }
    });
  }
}
