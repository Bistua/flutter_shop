import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/ui/page/dashboard/home_page.dart';
import 'package:flutter_lib/ui/page/dashboard/user_home_page.dart';
import 'package:flutter_lib/ui/page/shop/shop_cart_list.dart';
import 'package:flutter_lib/ui/page/shop/shop_category_list.dart';
import 'package:flutter_lib/ui/widgets/banner/banner_evalutor.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:flutter_test/flutter_test.dart';

class DashboardPage extends StatefulWidget {
  @override
  DashboardPageState createState() => DashboardPageState();
}

class Model extends Object with BannerWithEval {
  final String imgUrl;

  Model({this.imgUrl});

  @override
  get bannerUrl => imgUrl;
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: '热销精品', icon: Icons.directions_car),
  const Choice(title: '上新好货', icon: Icons.directions_bike),
  const Choice(title: '全部分类', icon: Icons.directions_boat),
  const Choice(title: '邀请返利', icon: Icons.directions_bus)
];

class DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int currentIndex = 0;
  final List<Widget> _children = [
    MyHomePage(),
    ShopCategoryListPage(title: "全部分类", showBackBtn: false),
    ShopCartListPage(false),
    UserHomeListPage(),
  ];

  @override
  Widget build(BuildContext context) {
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
