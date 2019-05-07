import 'dart:async';

import 'package:flutter_lib/model/Banner.dart';
import 'package:flutter_lib/model/HomeCategory.dart';
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
}
