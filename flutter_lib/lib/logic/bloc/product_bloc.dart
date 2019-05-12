import 'dart:async';

import 'package:flutter_lib/bridge/product_bridge.dart';
import 'package:flutter_lib/bridge/sku_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/productdetail.dart';
import 'package:flutter_lib/model/productitem.dart';
import 'package:flutter_lib/model/skuinfo.dart';

class ProductBloc {
  final ProductViewModel productViewModel = ProductViewModel();
  final productController = StreamController<List<ProductItem>>.broadcast();
  final productDetailController = StreamController<ProductDetail>.broadcast();
  final skuInfoController = StreamController<SkuInfo>.broadcast();

  Stream<List<ProductItem>> get productItems {
    return productController.stream;
  }

  Stream<ProductDetail> get productDetail {
    return productDetailController.stream;
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
        print(result.msg);
        productController.add(List());
      }
    });
  }

  /*
   * 获取精选列表的商品
   */
  getFeatures(int pageNo, int pageSize) {
    ProductBridge.getFeature(pageNo, pageSize).then((result) {
      if (result.code == 200) {
        ProductList productList = ProductList.fromJson(result.data);
        productController.add(productList.list);
      } else {
        print(result.msg);
        productController.addError(result);
      }
    });
  }

  queryProducts(String query, bool orderByAes) {
    ProductBridge.queryProduct(query, orderByAes, 1, 1000).then((result) {
      if (result.code == 200) {
        productController.add(null);
        ProductList productList = ProductList.fromJson(result.data);
        productController.add(productList.list);
      } else {
        print(result.msg);
        productController.addError(result);
      }
    });
  }

  getProduct(int productId) async {
    print("getProduct begin");
    Result result = await ProductBridge.getProduct(productId);
    if (result.code == 200) {
      Productdetail productList = Productdetail.fromJson(result.data);
      productDetailController.add(productList.list[0]);
      print("getProduct add");
    } else {
      print(result.msg);
      productDetailController.add(ProductDetail.N(""));
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
        print(result.msg);
        skuInfoController.addError(result);
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
