import 'package:flutter/material.dart';

class HomeItem {
  //图片的icon
  String icon;
  //标题
  String title;
  //传递子标题
  String subTitle;
  //=右键图标
  IconData arrowIcon;
  //跳转的页面
  String action;

  HomeItem(
      {this.icon,
      this.title,
      this.subTitle,
      this.arrowIcon,
      this.action});
}
