import 'dart:async';

import 'package:flutter_lib/model/Banner.dart';
import 'package:flutter_lib/model/HomeCategory.dart';
import 'package:flutter_lib/utils/http.dart';

class HomeBloc {
  final tabController = StreamController<List<DataListBean>>.broadcast();
  final homeCategoryController = StreamController<List<HomeCategory>>.broadcast();

  Stream<List<DataListBean>> get tabItems => tabController.stream;

  Stream<List<HomeCategory>> get homeCategory => homeCategoryController.stream;

  HomeBloc() {

  }


  Images v;
  getImages() async {
    if (v == null || v.code != 0) {
      v = await Http.getBanner();
    }
    if (v.code == 0) {
      tabController.add(v.data);
    }else{
      tabController.add(List());
    }
  }

  getHomeCategoryList() async {
    homeCategoryController.add(await Http.getHomeCategoryList());
  }

}
