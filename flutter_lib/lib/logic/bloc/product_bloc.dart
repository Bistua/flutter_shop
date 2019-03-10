import 'dart:async';

import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';

class ProductBloc {
  final ProductViewModel productViewModel = ProductViewModel();
  final productController = StreamController<List<Product>>();
  Stream<List<Product>> get productItems => productController.stream;

  ProductBloc() {
    productController.add(productViewModel.getProducts());
  }
}
