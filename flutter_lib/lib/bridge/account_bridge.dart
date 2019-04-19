import 'dart:convert';

import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/Result.dart';

class AccountBridge {
  static const String component = "account";
  /*
  获取短信验证码   type=0 注册
   */
  static Future<Result> getSmsCode(String type, String phone) async {
//    String data = await distest();
//    print(data);
//    Map<String, dynamic> map = json.decode(data);
//    return Result.fromJson(map);
    print("getSmsCode");
    return await Bridge.dispenser({
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

  static distest() {
    return json.encode({"code": 200});
  }

/*
  注册
 */
  static Future<Result> register(
      String phone, String smsCode, String inviteCode) async {
    print("register");
    return await Bridge.dispenser({
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
  static Future<Result> login(String type, String phone, String smsCode) {
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
  static Future<Result> wxLogin() {
    return Bridge.dispenser({
      "method": "wxlogin",
      "params": {
        "action": component,
        "arguments": {
          "method": "wxlogin",
          "data": {"phone": "123"},
        }
      }
    });
  }

  static Future<Result> getUserInfo(){
    return Bridge.dispenser({
      "method": "getUserInfo",
      "params": {
        "action": component,
        "arguments": {
          "method": "getUserInfo",
          "data": {"phone": "123"},
        }
      }
    });
  }
}
