import 'package:flutter/material.dart';

class SearchTab {
  String title;
  IconData icon;
  String image;
  List<String> items;
  BuildContext context;
  Color menuColor;

  SearchTab(
      {this.title,
        this.icon,
        this.image,
        this.items,
        this.context,
        this.menuColor = Colors.black});
}
