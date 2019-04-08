import 'package:flutter/material.dart';
import 'package:flutter_lib/model/product.dart';
import 'package:flutter_lib/ui/page/dashboard/dashboard.page.dart';
import 'package:flutter_lib/ui/page/dashboard/home_page.dart';
import 'package:flutter_lib/ui/page/dashboard/user_home_page.dart';
import 'package:flutter_lib/ui/page/invite/invite_friends.dart';
import 'package:flutter_lib/ui/page/invite/invite_input.dart';
import 'package:flutter_lib/ui/page/notfound/notfound_page.dart';
import 'package:flutter_lib/ui/page/order/all_shop_order_list.dart';
import 'package:flutter_lib/ui/page/order/mine_order.dart';
import 'package:flutter_lib/ui/page/shop/mine_collection.dart';
import 'package:flutter_lib/ui/page/order/order_detail.dart';
import 'package:flutter_lib/ui/page/shop/search_shop_list.dart';
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
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home: DashboardPage(),
//      localizationsDelegates: [
//        const TranslationsDelegate(),
//        GlobalMaterialLocalizations.delegate,
//        GlobalWidgetsLocalizations.delegate,
//      ],
//      supportedLocales: [
//        const Locale("en", "US"),
//        const Locale("hi", "IN"),
//      ],
      initialRoute: UIData.notFoundRoute,

      //routes
      routes: <String, WidgetBuilder>{
        UIData.homeRoute: (BuildContext context) => MyHomePage(),
        UIData.SearchShopList: (BuildContext context) => SearchShopList(),
        UIData.notFoundRoute: (BuildContext context) => NotFoundPage(),
        UIData.IviteFriendsPage: (BuildContext context) => IviteFriendsPage(),
        UIData.InviteInputPage: (BuildContext context) => InviteInputPage(),
        UIData.UserHomeListPage: (BuildContext context) => UserHomeListPage(),
        UIData.AllShopOrderPage: (BuildContext context) => AllShopOrderPage(),
        UIData.MineCollectionPage: (BuildContext context) => MineCollectionPage(),
        UIData.OrderDetailPage: (BuildContext context) => OrderDetailPage(),
        UIData.MineOrderPage: (BuildContext context) => MineOrderPage(),

      },
      onGenerateRoute: (RouteSettings settings) {
        final arguments = settings.arguments;
        switch (settings.name) {
          case UIData.ShopDetailPage:
            if (arguments is Product) {
              return new MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) => ShopDetailPage(arguments),
              );
            }
            break;
          case UIData.ShopCategoryList:
            if (arguments is String) {
              return new MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) => ShopCategoryList(arguments,true),
              );
            }
            break;
          case UIData.ShopListPage:
            if (arguments is String) {
              return new MaterialPageRoute(
                settings: settings,
                builder: (BuildContext context) =>
                    ShopListPage(title: arguments),
              );
            }
            break;
        }
      },
      onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
          builder: (context) => new NotFoundPage(
                appTitle: UIData.coming_soon,
//            icon: FontAwesomeIcons.solidSmile,
                title: UIData.coming_soon,
                message: "Under Development",
                iconColor: Colors.grey,
              )));

  @override
  Widget build(BuildContext context) {
    return materialApp;
  }
}
