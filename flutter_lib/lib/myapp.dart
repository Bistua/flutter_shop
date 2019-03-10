import 'package:flutter/material.dart';
import 'package:flutter_lib/ui/page/shop/shoplist.dart';
import 'package:flutter_lib/ui/page/notfound/notfound_page.dart';
import 'package:flutter_lib/utils/uidata.dart';
import 'package:flutter_lib/ui/page/dashboard/dashboard.page.dart';
import 'package:flutter_lib/ui/page/home_page.dart';

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
      home: MyHomePage(),
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
        UIData.shoplist: (BuildContext context) => ShopList(),
        UIData.notFoundRoute: (BuildContext context) => NotFoundPage(),
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
