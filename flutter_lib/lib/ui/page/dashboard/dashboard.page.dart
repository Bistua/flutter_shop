import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lib/ui/page/dashboard/home_page.dart';
import 'package:flutter_lib/ui/page/dashboard/user_home_page.dart';
import 'package:flutter_lib/ui/page/shop/shop_cart_list.dart';
import 'package:flutter_lib/ui/page/shop/shop_category_list.dart';
import 'package:flutter_lib/utils/uidata.dart';

class DashboardPage extends StatefulWidget {
  @override
  DashboardPageState createState() => DashboardPageState();
}



class DashboardPageState extends State<DashboardPage> {
  MyHomePage myHomePage = MyHomePage();
  ShopCategoryListPage shopCategoryListPage =
      ShopCategoryListPage(title: "全部分类", showBackBtn: false);
  ShopCartListPage shopCartListPage = ShopCartListPage(false);
  UserHomeListPage userHomeListPage = UserHomeListPage();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int currentIndex = 0;
  final List<Widget> _children = [];

  @override
  Widget build(BuildContext context) {
    _children.add(myHomePage);
    _children.add(shopCategoryListPage);
    _children.add(shopCartListPage);
    _children.add(userHomeListPage);
    return Scaffold(
      body: _children[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: UIData.ff353535,
              ),
              title: Text(
                '首页',
                style: TextStyle(color: UIData.ff353535, fontSize: 10),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
                color: UIData.ff353535,
              ),
              title: Text(
                '分类',
                style: TextStyle(color: UIData.ff353535, fontSize: 10),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_shopping_cart,
                color: UIData.ff353535,
              ),
              title: Text(
                '购物车',
                style: TextStyle(color: UIData.ff353535, fontSize: 10),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: UIData.ff353535,
              ),
              title: Text(
                '我的',
                style: TextStyle(color: UIData.ff353535, fontSize: 10),
              )),
        ],
        currentIndex: this.currentIndex,
        onTap: (selectIndex) {
          setState(() {
            this.currentIndex = selectIndex;
          });
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
