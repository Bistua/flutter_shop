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

  CategoryBloc() {
    getCategories();
  }

  getCategories() {
    print("getCategories begin");
    CategoryBridge.getCategories().then((result) {
      if (result.code == 200) {
        CategoryList categoryList = CategoryList.fromJson(result.data);
        categoryViewModel.categorysItems = categoryList.list;
        categoryController.add(categoryViewModel.categorysItems);
        print("getCategories add");
      } else {
        print(result.msg == null ? "未返回错误信息" : result.msg);
        if (categoryController.isClosed || categoryController.isPaused) {
          return;
        }
        categoryController.add(List());
      }
    });
  }

  getSubCategories(int categoryId) {
    print("getSubCategories begin");
    CategoryBridge.getSubCategories(categoryId).then((result) {
      if (result.code == 200) {
        CategoryList subCategoryList = CategoryList.fromJson(result.data);
        subCategoryController.add(subCategoryList.list);
        print("getSubCategories add");
      } else {
        print(result.msg == null ? "未返回错误信息" : result.msg);
        if (subCategoryController.isClosed || subCategoryController.isPaused) {
          return;
        }
        subCategoryController.add(List());
      }
    });
  }

  void close() {
    categoryController?.close();
  }
}
