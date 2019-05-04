import 'package:flutter/material.dart';
import 'package:flutter_lib/model/searchTab.dart';

class TabViewModel {
  List<SearchTab> tabItems;

  TabViewModel({this.tabItems});

  getMenuItems() {
    return tabItems = <SearchTab>[
      SearchTab(
          title: "综合排序",
          menuColor: Color(0xff050505),
          icon: Icons.arrow_drop_down,
          items: ["home", "Profile 2", "Profile 3", "Profile 4"]),
      SearchTab(
          title: "销量", menuColor: Color(0xff050505), icon: null, items: []),
      SearchTab(title: "价格", menuColor: Color(0xff050505), items: []),
    ];
  }
}
