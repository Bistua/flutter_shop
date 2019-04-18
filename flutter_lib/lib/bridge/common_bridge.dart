import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_lib/model/Result.dart';

class Bridge {
  static const _bridgePlatform =
      const MethodChannel("com.ym.framework.plugins/bridge");

  static Future<Result> dispenser(var dispenser) async {
    String method = dispenser['method'];
    var params = dispenser['params'];
    print(method);
    print(params);
    String data = await _bridgePlatform.invokeMethod(method, params);
    if (data != null) {
      print("bridge result:"+data);
      return Result.fromJson(data);
    }
    return Result.fromJson(json.encode({"code": -1, "msg": "无结果"}));
  }

  static Future<Result> showShortToast(String message) {
    message = message.replaceAll(" ", "");
    return dispenser({
      "method": "showShortToast",
      "params": {
        "message": message,
      },
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

  static void gotoVideoPage() {
    dispenser({
      "method": "video",
      "params": {"action": "navigate"}
    });
  }

  static Future<Result> httpRequest(var requestType, String url) async {
    return dispenser({
      "method": "get",
      "params": {"action": "http", "message": url}
    });
  }

  static Future<Result> getBatteryLevel() async {
    return dispenser({
      "method": "getBatteryLevel",
      "arguments": {"action": "battery", "message": "msg"}
    });
  }
}
