import 'dart:async';

import 'package:flutter_lib/bridge/category_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/category_view_model.dart';
import 'package:flutter_lib/model/category.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryBloc {
  final CategoryViewModel categoryViewModel = CategoryViewModel();
  final categoryController = StreamController<List<Category>>();

  Stream<List<Category>> get categoryItems {
    return categoryController.stream;
  }

  CategoryBloc();

  getCategories() {
    CategoryBridge.getCategories().then((result) {
      if (result.code == 200) {
        //todo 解析data
        categoryViewModel.categorysItems = categoryViewModel.getCategory();
        //然后add  每次add相当于发送了一次事件
        categoryController.add(categoryViewModel.categorysItems);
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
