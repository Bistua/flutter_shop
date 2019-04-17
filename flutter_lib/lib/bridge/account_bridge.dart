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

//    return await Bridge.dispenser({
//      "method": "getSmsCode",
//      "params": {
//        "action": component,
//        "arguments": {
//          "method": "getSmsCode",
//          "data": {"type": type, "phone": phone}
//        }
//      }
//    });

    print("getSmsCode");
    String data = await Bridge.dispenser({
      "method": "getSmsCode",
      "params": {
        "action": component,
        "arguments": {
          "method": "getSmsCode",
          "data": {"type": type, "phone": phone}
        }
      }
    });
    print(data);
    Map<String, dynamic> map = json.decode(data);
    return Result.fromJson(map);
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
    String data = await Bridge.dispenser({
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
    print(data);
    Map<String, dynamic> map = json.decode(data);
    return Result.fromJson(map);
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
  static Future<String> wxLogin() {
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
}
