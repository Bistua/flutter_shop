import 'dart:async';

import 'package:flutter_lib/bridge/category_bridge.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/category_view_model.dart';
import 'package:flutter_lib/model/category.dart';
import 'package:flutter_lib/model/categorylist.dart';
import 'package:flutter_lib/utils/uidata.dart';

class CategoryBloc {
  final CategoryViewModel categoryViewModel = CategoryViewModel();
  final categoryController = StreamController<List<Category>>();

  final subCategoryController = StreamController<List<Category>>();

  Stream<List<Category>> get categoryItems {
    return categoryController.stream;
  }

  Stream<List<Category>> get suCategoryItems {
    return subCategoryController.stream;
  }

  CategoryBloc();

  getCategories() {
    CategoryBridge.getCategories().then((result) {
      if (result.code == 200) {
        CategoryList categoryList = CategoryList.fromJson(result.data);
        categoryViewModel.categorysItems = categoryList.list;
        categoryController.add(categoryViewModel.categorysItems);
      } else {
        Bridge.showLongToast(result.msg);
        categoryController.add(List());
      }
    });
  }

  getSubCategories(int categoryId) {
    CategoryBridge.getSubCategories(categoryId).then((result) {
      if (result.code == 200) {
        CategoryList subCategoryList = CategoryList.fromJson(result.data);
        subCategoryController.add(subCategoryList.list);
      } else {
        Bridge.showLongToast(result.msg);
        categoryController.add(List());
      }
    });
  }
}
