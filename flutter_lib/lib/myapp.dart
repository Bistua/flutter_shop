import 'package:flutter/material.dart';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/OrderComment.dart';
import 'package:flutter_lib/model/category.dart';
import 'package:flutter_lib/ui/page/account/login.dart';
import 'package:flutter_lib/ui/page/account/register.dart';
import 'package:flutter_lib/ui/page/dashboard/dashboard.page.dart';
import 'package:flutter_lib/ui/page/dashboard/home_page.dart';
import 'package:flutter_lib/ui/page/dashboard/user_home_page.dart';
import 'package:flutter_lib/ui/page/invite/invite_friends.dart';
import 'package:flutter_lib/ui/page/invite/invite_input.dart';
import 'package:flutter_lib/ui/page/notfound/notfound_page.dart';
import 'package:flutter_lib/ui/page/order/all_shop_order_list.dart';
import 'package:flutter_lib/ui/page/order/oder_comment.dart';
import 'package:flutter_lib/ui/page/order/order_comment_list.dart';
import 'package:flutter_lib/ui/page/order/order_detail.dart';
import 'package:flutter_lib/ui/page/shop/mine_collection.dart';
import 'package:flutter_lib/ui/page/shop/search_shop_list.dart';
import 'package:flutter_lib/ui/page/shop/shop_cart_list.dart';
import 'package:flutter_lib/ui/page/shop/shop_category_list.dart';
import 'package:flutter_lib/ui/page/shop/shop_detail.dart';
import 'package:flutter_lib/ui/page/shop/shop_list.dart';
import 'package:flutter_lib/utils/uidata.dart';

class MyApp extends StatelessWidget {
  final materialApp = MaterialApp(
      title: UIData.appName,
      theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: UIData.quickFont,
          primarySwatch: Colors.grey,
          brightness: Brightness.light,
          hintColor: Colors.transparent),
      debugShowCheckedModeBanner: true,
      showPerformanceOverlay: false,
      home: DashboardPage(),
      initialRoute: UIData.notFoundRoute,
      routes: <String, WidgetBuilder>{
        UIData.ShopCartListPage: (BuildContext context) =>
            ShopCartListPage(true),
        UIData.Login: (BuildContext context) => LoginPage(),
        UIData.homeRoute: (BuildContext context) => MyHomePage(),
        UIData.SearchShopList: (BuildContext context) => SearchShopListPage(),
        UIData.notFoundRoute: (BuildContext context) => NotFoundPage(),
        UIData.IviteFriendsPage: (BuildContext context) => InviteFriendsPage(),
        UIData.InviteInputPage: (BuildContext context) => InviteInputPage(),
        UIData.UserHomeListPage: (BuildContext context) => UserHomeListPage(),
        UIData.MineCollectionPage: (BuildContext context) =>
            MineCollectionPage(),
        UIData.OrderCommentListPage: (BuildContext context) =>
            OrderCommentListPage(),
        UIData.Register: (BuildContext context) => RegisterPage()
      },
      onGenerateRoute: (RouteSettings settings) {
        final arguments = settings.arguments;
        switch (settings.name) {
          case UIData.ShopDetailPage:
            if (arguments is String) {
              return new MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) =>
                    ShopDetailPage(int.parse(arguments)),
              );
            }
            break;
          case UIData.ShopCategoryList:
            if (arguments is String) {
              return new MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) =>
                    ShopCategoryListPage(title: arguments, showBackBtn: true),
              );
            }
            break;
          case UIData.ShopListPage:
            if (arguments is Category) {
              return new MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) => ShopListPage(
                    categoryId: arguments.id, title: arguments.name),
              );
            }
            break;
          case UIData.OrderCommentPage:
            if (arguments is OrderComment) {
              return new MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) => OrderCommentPage(arguments),
              );
            }
            break;
          case UIData.OrderDetailPage:
            if (arguments is String) {
              return new MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) => OrderDetailPage(arguments),
              );
            }
            break;
          case UIData.AllShopOrderPage:
            if (arguments is int) {
              return new MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) => AllShopOrderPage(arguments),
              );
            }
            break;
        }
      },
      onUnknownRoute: (RouteSettings settings) {
//        final arguments = settings.arguments;
//        switch (settings.name) {
//          case UIData.ShopDetailPage:
//
//            break;
//        }
        new MaterialPageRoute(
            builder: (context) => new NotFoundPage(
              appTitle: UIData.coming_soon,
              title: UIData.coming_soon,
              message: "Under Development",
              iconColor: Colors.grey,
            ));
      });

  @override
  Widget build(BuildContext context) {
    Bridge.context = context;
    return materialApp;
  }
}
