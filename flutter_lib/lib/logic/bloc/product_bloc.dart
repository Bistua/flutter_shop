import 'dart:async';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/product_bridge.dart';
import 'package:flutter_lib/bridge/sku_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';
import 'package:flutter_lib/model/Result.dart';

import 'package:flutter_lib/model/productitem.dart';
import 'package:flutter_lib/model/productlist.dart';
import 'package:flutter_lib/model/skuinfo.dart';

class ProductBloc {
  final ProductViewModel productViewModel = ProductViewModel();
  final productController = StreamController<List<ProductItem>>();
  final skuInfoController = StreamController<SkuInfo>.broadcast();

  Stream<List<ProductItem>> get productItems {
    return productController.stream;
  }

  Stream<SkuInfo> get skuInfo {
    return skuInfoController.stream;
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

  getProduct(int productId) async {
    print("getProduct begin");
    Result result = await ProductBridge.getProduct(productId);
    if (result.code == 200) {
      ProductList productList = ProductList.fromJson(result.data);
      productController.add(productList.list);
      print("getProduct add");

    } else {
      Bridge.showLongToast(result.msg);
      productController.add(null);
    }
  }

  getProductSkuInfo(int productId) {
    print("getProductSkuInfo begin");
    SkuBridge.findGoodsSku(productId.toString()).then((result) {
      if (result.code == 200) {
        print(result.toString());
        SkuInfo productList = SkuInfo.fromJson(result.data);
        skuInfoController.add(productList);
        print("getProduct sku add");
      } else {
        Bridge.showLongToast(result.msg);
      }
    });
  }

  close() {
    if (skuInfoController != null) {
      skuInfoController.close();
    }
    if (productController != null) {
      productController.close();
    }
  }
}
