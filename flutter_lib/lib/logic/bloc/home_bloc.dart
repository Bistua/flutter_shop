import 'dart:async';

import 'package:flutter_lib/model/Banner.dart';
import 'package:flutter_lib/model/HomeCategory.dart';
import 'package:flutter_lib/model/promotion.dart';
import 'package:flutter_lib/model/special.dart';
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
    if (v == null || v.isEmpty) {
      v = await Http.getBanner();
    }

    tabController.add(v);
  }

  getHomeCategoryList() async {
    homeCategoryController.add(await Http.getHomeCategoryList());
  }


  final promotionController =
  StreamController<List<Promotion>>.broadcast();
  Stream<List<Promotion>> get promotions => promotionController.stream;

  getPromotion() async{
    promotionController.add(await Http.getPromotion());
  }


  final specialController =
  StreamController<List<Special>>.broadcast();
  Stream<List<Special>> get specials => specialController.stream;

  getSpecial() async{
    specialController.add(await Http.getSpecial());
  }

  getHomeAll(){
    getImages();
    getHomeCategoryList();
    getPromotion();
    getSpecial();
  }
}
