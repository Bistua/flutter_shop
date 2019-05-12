import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lib/ui/page/account/login.dart';

class BristuaRouter {
  /*
   * 路由到主页面
   */
  static void routerUserLogin(BuildContext context) {
    Navigator.pop(context, false);
    Route route = MaterialPageRoute(builder: (context) => LoginPage());
    Navigator.push(context, route);
  }
}
