import 'package:flutter/services.dart';

class Bridge {
  static const _bridgePlatform =
      const MethodChannel("com.ym.framework.plugins/bridge");

  static Future<String> dispenser(var dispenser) async {
    try {
      String method = dispenser['method'];
      var params = dispenser['params'];
      return await _bridgePlatform.invokeMethod(method, params);
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  static void showShortToast(String message) {
    message = message.replaceAll(" ", "");
    dispenser({
      "method": "showShortToast",
      "params": {"action": "toast", "message": message}
    });
  }

  static void showLongToast(String message) {
    message = message.replaceAll(" ", "");
    dispenser({
      "method": "showLongToast",
      "params": {"action": "toast", "message": message}
    });
  }

  static void showToast(String message, int duration) {
    message = message.replaceAll(" ", "");
    dispenser({
      "method": "showToast",
      "params": {"action": "toast", "message": message, "duration": duration}
    });
  }

  /*
   *
   *获取产品列表
   */
  static Future<String> getProducts(String type) {
    return dispenser({
      "method": "getProducts",
      "params": {
        "action": "getProducts",
        "data": {"type": type}
      }
    });
  }

  /*
  获取短信验证码
   * type=0 注册
   */
  static Future<String> getSmsCode(String type, String phone) {
    return dispenser({
      "method": "getSmsCode",
      "params": {
        "action": "getSmsCode",
        "data": {"type": type, "phone": phone}
      }
    });
  }

/*
  注册
 */
  static Future<String> register(
      String phone, String smsCode, String inviteCode) {
    return dispenser({
      "method": "register",
      "params": {
        "action": "register",
        "data": {"phone": phone, "smsCode": smsCode, "inviteCode": inviteCode},
      }
    });
  }
}
