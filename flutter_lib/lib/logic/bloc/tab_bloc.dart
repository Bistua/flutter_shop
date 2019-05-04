import 'dart:async';

import 'package:flutter_lib/logic/viewmodel/tab_view_model.dart';

class TabBloc {
  final _tabVM = TabViewModel();
  final tabController = StreamController<List<TabViewModel>>();

  Stream<List<TabViewModel>> get tabItems => tabController.stream;

  TabBloc() {
    tabController.add(_tabVM.getMenuItems());
  }
}
