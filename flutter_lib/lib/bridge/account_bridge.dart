import 'package:flutter_lib/bridge.dart';

class AccountBridge {
  static const String component = "account";
  /*
  获取短信验证码   type=0 注册
   */
  static Future<String> getSmsCode(String type, String phone) {
    return Bridge.dispenser({
      "method": "getSmsCode",
      "params": {
        "action": component,
        "arguments": {
          "method": "getSmsCode",
          "data": {"type": type, "phone": phone}
        }
      }
    });
  }

/*
  注册
 */
  static Future<String> register(
      String phone, String smsCode, String inviteCode) {
    return Bridge.dispenser({
      "method": "register",
      "params": {
        "action": component,
        "arguments": {
          "method": "register",
          "data": {
            "phone": phone,
            "smsCode": smsCode,
            "inviteCode": inviteCode
          },
        }
      }
    });
  }

  /*
  登录
 */
  static Future<String> login(String type, String phone, String smsCode) {
    return Bridge.dispenser({
      "method": "login",
      "params": {
        "action": component,
        "arguments": {
          "method": "login",
          "data": {"phone": phone, "smsCode": smsCode},
        }
      }
    });
  }

  /*
  微信登录
 */
  static Future<String> wxLogin(String phone) {
    return Bridge.dispenser({
      "method": "wxlogin",
      "params": {
        "action": component,
        "arguments": {
          "method": "wxlogin",
          "data": {"phone": phone},
        }
      }
    });
  }
}
