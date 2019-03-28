import 'package:flutter_lib/model/product.dart';

class ShopCartManager {
  factory ShopCartManager() => _getInstance();
  static ShopCartManager get instance => _getInstance();
  static ShopCartManager _instance;

  static ShopCartManager _getInstance() {
    if (_instance == null) {
      _instance = new ShopCartManager._internal();
    }
    return _instance;
  }

  ShopCartManager._internal() {
    // 初始化
  }

  List<Product> products = new List();

  int size() {
    return products.length;
  }

  void addProduct(Product product) {
    products.add(product);
  }

  double getTotalPrice() {
    double totalPrice = 0;
    products.forEach((f) {
      totalPrice = totalPrice + f.priceNum;
    });
    return totalPrice;
  }

  List<Product> getProducts(){
    return products;
  }
}
