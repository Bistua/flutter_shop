import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lib/logic//bloc/userinfo_bloc.dart';
import 'package:flutter_lib/logic/viewmodel/homeitem_view_model.dart';
import 'package:flutter_lib/model/homeitem.dart';
import 'package:flutter_lib/model/userinfo.dart';
import 'package:flutter_lib/utils/uidata.dart';

class UserHomeListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserHomeState();
  }
}

class _UserHomeState extends State<UserHomeListPage> {
  HomeItemViewModel homeItemViewModel = HomeItemViewModel();
  List<HomeItem> homeItems;
  UserInfoBloc userInfoBloc = new UserInfoBloc();

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
//      statusBarColor: UIData.fffa4848, //or set color with: Color(0xFF0000FF)
//    ));
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
              child: new Scaffold(body: bodyData())),
        ],
      ),
    );
  }

  /*
   * 创建头部布局
   */
  Widget buildHeader(Userinfo userInfo) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Card(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, UIData.AllShopOrderPage,arguments: 0);
                },
                child: Row(
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
                    ),
                  ],
                ),
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
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 8),
                          ),
                          Text(
                            "待付款",
                            style:
                                TextStyle(color: UIData.ff353535, fontSize: 12),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, UIData.AllShopOrderPage, arguments: 1);
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, UIData.AllShopOrderPage,
                            arguments: 2);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            child: Image.asset(
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
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, UIData.AllShopOrderPage,
                            arguments: 3);
                      },
                      child: Column(
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
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, UIData.AllShopOrderPage,
                            arguments: 4);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            child: Image.asset(
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

  Widget buildListIItem(int index, Userinfo userInfo) {
    homeItems = homeItemViewModel.getMenuItems(userInfo);
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
                      child: Image.asset(
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
        //未登录的用户，要主动跳转
        if (userInfo == null) {
          Navigator.pushNamed(context, UIData.Login);
          return;
        }
        Navigator.pushNamed(context, homeItem.action);
      },
    );
  }

  Widget bodyData() {
    userInfoBloc.getUserInfo();
    return StreamBuilder<Userinfo>(
        stream: userInfoBloc.userInfoStream.stream,
        builder: (context, snapshot) {
          return getWidget(snapshot.data);
        });
  }

  /*
   * 获取配置信息
   */
  CustomScrollView getWidget(Userinfo userInfo) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: false,
          expandedHeight: 155.0,
          floating: false,
          pinned: false,
          //固定在顶部
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
                      Padding(
                        child: CircleAvatar(
                            radius: 30, backgroundImage: getImage(userInfo)),
                        padding: EdgeInsets.fromLTRB(22, 0, 0, 0),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 50, 8, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Padding(
                                child: Text(
                                    userInfo == null
                                        ? "点此登录"
                                        : userInfo.nickName,
                                    style: TextStyle(
                                        color: UIData.fff, fontSize: 18)),
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              ),
                              Padding(
                                child: Text(
                                    userInfo == null
                                        ? "登录后获取更多精彩内容"
                                        : userInfo.phone,
                                    style: TextStyle(
                                        color: UIData.fff, fontSize: 12)),
                                padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                //如果用户信息为空，那么我们就要去登录了，如果用户信息不为空，这时候，就要验证下
                gotoLogin(userInfo);
              },
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              buildHeader(userInfo),
            ],
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 60,
          delegate: SliverChildBuilderDelegate(
            (context, index) => buildListIItem(index, userInfo),
            childCount: 6,
          ),
        ),
      ],
    );
  }

  ImageProvider getImage(Userinfo userInfo) {
    if (userInfo == null) {
      return new AssetImage("images/user_icon.png");
    }
    return new NetworkImage(userInfo.userImgUrl);
  }

  /*
   * 执行去登录或者去激活的操作
   */
  void gotoLogin(Userinfo userInfo) {
    print("跳转至登录页面");
    if (userInfo == null) {
      Navigator.pushNamed(context, UIData.Login);
      return;
    }
    print("跳转至登录页面2:" + userInfo.phone);
    //判断用户手机号是否存在
    if (userInfo.phone == "-") {
      print("去执行页面跳转");
      //执行去绑定手机号
      Navigator.pushNamed(context, UIData.Register);
      return;
    }
  }
}
