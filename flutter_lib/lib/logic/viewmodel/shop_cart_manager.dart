import 'package:flutter_lib/model/product.dart';

class ShopCartManager {
  factory ShopCartManager() => _getInstance();
  static ShopCartManager get instance => _getInstance();
  static ShopCartManager _instance;
  List<Product> products = new List();


  static ShopCartManager _getInstance() {
    if (_instance == null) {
      _instance = new ShopCartManager._internal();
    }
    return _instance;
  }

  ShopCartManager._internal() {
    // 初始化
    products = new List();
  }



  int size() {
    int totalCount = 0;
    products.forEach((f) {
      totalCount = totalCount + f.count;
    });
    return totalCount;
  }

  void addProduct(Product product) {
    print("0" + product.toString());
    if (products.isEmpty) {
      product.count = 1;
      products.add(product);
      return;
    }
    bool has = false;
    products.forEach((f) {
      if (f == product) {
        f.count++;
        has = true;
        print("1" + product.toString());
      } else {
        has = false;
        product.count = 1;
      }
    });
    if(!has){
      products.add(product);
    }
  }

  void remove(Product product) {
    print("0" + product.toString());
    products.forEach((f) {
      if (f == product) {
        product.count--;
        if (product.count <= 1) {
          product.count = 1;
        }
      }
    });
  }

  double getTotalPrice() {
    double totalPrice = 0;
    products.forEach((f) {
      if (f.isChecked) {
        totalPrice = totalPrice + f.priceNum * f.count;
      }
    });
    return totalPrice;
  }

  List<Product> getProducts() {
    return products;
  }

  List<Product> getCheckedProducts() {
    List<Product> checkedProducts = new List();

    products.forEach((f) {
      if (f.isChecked) {
        checkedProducts.add(f);
      }
    });
    return checkedProducts;
  }

  bool isAllChecked() {
    bool isAllChecked = true;
    if (products.isEmpty) {
      return false;
    }
    products.forEach((f) {
      if (!f.isChecked) {
        isAllChecked = false;
        return isAllChecked;
      }
    });
    return isAllChecked;
  }
}
