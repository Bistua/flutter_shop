import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib/bridge/info_bridge.dart';
import 'package:flutter_lib/logic/viewmodel/homeitem_view_model.dart';
import 'package:flutter_lib/model/homeitem.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'dart:ui';

class UserHomeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserHomeState();
  }
}

class _UserHomeState extends State<UserHomeListPage> {
  HomeItemViewModel homeItemViewModel = HomeItemViewModel();
  List<HomeItem> homeItems;

  @override
  Widget build(BuildContext context) {
    homeItems = homeItemViewModel.getMenuItems();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: UIData.fffa4848, //or set color with: Color(0xFF0000FF)
    ));
    //InfoBridge.wxInfo();
    return Scaffold(
      body: buildBody(),
    );
  }

  Container buildBody() {
    return Container(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  centerTitle: false,
                  expandedHeight: 155.0,
                  floating: false,
                  pinned: false, //固定在顶部
                  automaticallyImplyLeading: false,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    background: GestureDetector(
                      child: Container(
                        color: UIData.fffa4848,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(22, 56, 8, 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                        "小猪佩奇",
                                        style: TextStyle(
                                            color: UIData.fff, fontSize: 20),
                                      ),
                                      Text(
                                        "账号：18610001234",
                                        style: TextStyle(
                                            color: UIData.fff, fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      "http://pic1.win4000.com/wallpaper/a/59322eda4daf0.jpg"),
                                ),
                                padding: EdgeInsets.fromLTRB(0, 0, 22, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, UIData.Login);
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      buildHeader(),
                    ],
                  ),
                ),
                SliverFixedExtentList(
                  itemExtent: 60,
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => buildListIItem(index),
                    childCount: homeItems.length,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Card(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "我的订单",
                      style: TextStyle(color: UIData.ff353535, fontSize: 15),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "查看全部订单",
                            style:
                                TextStyle(color: UIData.ff999999, fontSize: 15),
                          ),
                          Padding(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: UIData.ff999999,
                              size: 9,
                            ),
                            padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, UIData.AllShopOrderPage);
                      },
                    ),
                  ),
                ],
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 8, 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            child: Image.asset(
                              "images/order1.png",
                              width: 22.0,
                              height: 22.0,
                            ),
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                          ),
                          Text(
                            "待付款",
                            style:
                                TextStyle(color: UIData.ff353535, fontSize: 12),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, UIData.AllShopOrderPage);
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child:Image.asset(
                            "images/order2.png",
                            width: 22.0,
                            height: 22.0,
                          ),
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                        ),
                        Text(
                          "待发货",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child: Image.asset(
                            "images/order3.png",
                            width: 22.0,
                            height: 22.0,
                          ),
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                        ),
                        Text(
                          "待收货",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 12),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          child:Image.asset(
                            "images/order4.png",
                            width: 22.0,
                            height: 22.0,
                          ),
                          padding: EdgeInsets.fromLTRB(0, 12, 0, 8),
                        ),
                        Text(
                          "待评价",
                          style:
                              TextStyle(color: UIData.ff353535, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListIItem(int index) {
    HomeItem homeItem = homeItems[index];
    return GestureDetector(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      child:
                      Image.asset(
                        homeItem.icon,
                        width: 22.0,
                        height: 22.0,
                      ),
                      padding: EdgeInsets.fromLTRB(22, 12, 16, 8),
                    ),
                    Text(
                      homeItem.title,
                      style: TextStyle(color: UIData.ff353535, fontSize: 15),
                    ),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        homeItem.subTitle,
                        style: TextStyle(color: UIData.ff999999, fontSize: 15),
                      ),
                      Padding(
                        child: Icon(
                          homeItem.arrowIcon,
                          color: UIData.ff999999,
                          size: 14,
                        ),
                        padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
              child: Divider(),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, homeItem.action);
      },
    );
  }
}
