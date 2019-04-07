import 'dart:async';
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_lib/bridge.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/logic/viewmodel/product_view_model.dart';

class ProductBloc {
  final ProductViewModel productViewModel = ProductViewModel();
  final productController = StreamController<List<Product>>();
  Stream<List<Product>> get productItems {
    return productController.stream;
  }

  ProductBloc() {
   Future<String> future =  productViewModel.getProducts("1");
   future.then((string){
     Map<String, dynamic> products = json.decode(string);


//     productController.add()
     
   }).catchError((error){
     print(error);
   });
  
  }


}
