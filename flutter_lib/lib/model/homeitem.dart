import 'package:flutter/material.dart';

class HomeItem {
  IconData icon;
  String title;
  String subTitle;
  IconData arrowIcon;

  String action;

  HomeItem(
      {this.icon,
      this.title,
      this.subTitle,
      this.arrowIcon,
      this.action});
}
