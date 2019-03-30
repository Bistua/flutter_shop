import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              '首页',
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            title: Text(
              '分类',
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.add_shopping_cart,
            ),
            title: Text(
              '购物车',
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text(
              '我的',
            )),
      ],
      currentIndex: 0,
    );
  }
}
