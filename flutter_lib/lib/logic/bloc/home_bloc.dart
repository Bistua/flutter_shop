import 'dart:async';

import 'package:flutter_lib/logic/viewmodel/tab_view_model.dart';
import 'package:flutter_lib/model/Banner.dart';
import 'package:flutter_lib/utils/http.dart';

class HomeBloc {
  final tabController = StreamController<List<DataListBean>>.broadcast();

  Stream<List<DataListBean>> get tabItems => tabController.stream;

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
      tabController.add(null);
    }
  }
}
