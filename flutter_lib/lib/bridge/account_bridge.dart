
import 'package:flutter_lib/bridge.dart';

class AccountBridge {


  /*
  获取短信验证码   type=0 注册
   */
  static Future<String> getSmsCode(String type, String phone) {
    return Bridge.dispenser({
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
    return Bridge.dispenser({
      "method": "register",
      "params": {
        "action": "register",
        "data": {"phone": phone, "smsCode": smsCode, "inviteCode": inviteCode},
      }
    });
  }

  /*
  登录
 */
  static Future<String> login(String type,
      String phone, String smsCode) {
    return Bridge.dispenser({
      "method": "login",
      "params": {
        "action": "login",
        "data": {"type": type,"phone": phone, "smsCode": smsCode},
      }
    });
  }

}