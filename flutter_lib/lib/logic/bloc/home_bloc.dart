import 'dart:async';

import 'package:flutter_lib/model/Banner.dart';
import 'package:flutter_lib/model/HomeCategory.dart';
import 'package:flutter_lib/model/Result.dart';
import 'package:flutter_lib/model/promotion.dart';
import 'package:flutter_lib/model/special.dart';
import 'package:flutter_lib/utils/http.dart';

class HomeBloc {
  final tabController = StreamController<List<DataListBean>>.broadcast();
  final homeCategoryController =
      StreamController<List<HomeCategory>>.broadcast();

  Stream<List<DataListBean>> get tabItems => tabController.stream;

  Stream<List<HomeCategory>> get homeCategory => homeCategoryController.stream;

  HomeBloc() {}

  List<DataListBean> v;
  getImages() async {
    if (v != null && v.isNotEmpty) {
      tabController.add(v);
    } else {
      Result result = await Http.getBanner();
      if (result != null && result.code == 0) {
        dynamic data = result.data;
        List<dynamic> l = data["list"];
        List<DataListBean> c = l.map((f) {
          return DataListBean.fromJson(f);
        }).toList();
        print(data);
        if (v == null || v.isEmpty) {
          v = c;
        }
        tabController.add(v);
      } else {
        tabController.addError(result);
      }
    }
  }

  getHomeCategoryList() async {
    Result result = await Http.getHomeCategoryList();
    if (result != null && result.code == 0) {
      dynamic data = result.data;
      List<dynamic> l = data["list"];
      List<HomeCategory> c = l.map((f) {
        return HomeCategory.fromJson(f);
      }).toList();
      print(data);
      homeCategoryController.add(c);
    } else {
      homeCategoryController.addError(result);
    }
  }

  final promotionController = StreamController<List<Promotion>>.broadcast();
  Stream<List<Promotion>> get promotions => promotionController.stream;

  getPromotion() async {
    Result result = await Http.getPromotion();
    if (result != null && result.code == 0) {
      dynamic data = result.data;
      List<dynamic> l = data["list"];
      List<Promotion> c = l.map((f) {
        return Promotion.fromJson(f);
      }).toList();
      print(data);
      promotionController.add(c);
    } else {
      promotionController.addError(result);
    }
  }

  final specialController = StreamController<List<Special>>.broadcast();
  Stream<List<Special>> get specials => specialController.stream;

  getSpecial() async {
    Result result = await Http.getSpecial();
    if (result != null && result.code == 0) {
      dynamic data = result.data;
      List<dynamic> l = data["list"];
      List<Special> c = l.map((f) {
        return Special.fromJson(f);
      }).toList();
      print(data);
      specialController.add(c);
    } else {
      specialController.addError(result);
    }
  }

  getHomeAll() {
    getImages();
    getHomeCategoryList();
    getPromotion();
    getSpecial();
  }
}
