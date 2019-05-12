import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lib/model/Result.dart';

class Bridge {
  static const _bridgePlatform =
      const MethodChannel("com.ym.framework.plugins/bridge");

  static BuildContext context;

  static Future<Result> dispenser(var dispenser) async {
    String method = dispenser['method'];
    var params = dispenser['params'];
    print(method);
    print(params);
    String data = await _bridgePlatform.invokeMethod(method, params);
    Result result;
    if (data != null) {
      print("bridge result:" + data);
      result = Result.fromJson(data);
    } else {
      result = Result.fromJson(json.encode({"code": -1, "msg": "无结果"}));
    }

    return result;
  }

  static webview(String url) {
    if (url == null || url.isEmpty) {
      return;
    }
    url = "" + url;
    url = url.replaceAll(" ", "");
    dispenser({
      "method": "webview",
      "params": json.encode({
        "url": url,
      }),
    });
  }

  static showShortToast(String message) {
    if (message == null || message.isEmpty) {
      return;
    }
    message = "" + message;
    message = message.replaceAll(" ", "");
    dispenser({
      "method": "showShortToast",
      "params": json.encode({
        "message": message,
      }),
    });
  }

  static void showLongToast(String message) {
    if (message == null || message.isEmpty) {
      return;
    }
    message = message.replaceAll(" ", "");
    dispenser({
      "method": "showLongToast",
      "params": json.encode({
        "message": message,
      }),
    });
  }

  static void showToast(String message, int duration) {
    if (message == null || message.isEmpty) {
      return;
    }
    message = "" + message;
    message = message.replaceAll(" ", "");
    dispenser({
      "method": "showToast",
      "params": json.encode({
        "message": message,
      }),
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
