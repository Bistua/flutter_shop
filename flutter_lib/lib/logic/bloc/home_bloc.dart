import 'dart:async';

import 'package:flutter_lib/logic/viewmodel/tab_view_model.dart';
import 'package:flutter_lib/model/Banner.dart';
import 'package:flutter_lib/utils/http.dart';

class HomeBloc {
  final tabController = StreamController<List<DataListBean>>.broadcast();

  Stream<List<DataListBean>> get tabItems => tabController.stream;

  HomeBloc();

  getImages() async {
    Images v = await Http.getBanner();
    print("image");
    print(v.toString());
    if (v.code == 0) {
      tabController.add(v.data);
    }
  }
}
