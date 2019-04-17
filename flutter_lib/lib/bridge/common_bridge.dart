import 'package:flutter/services.dart';

class Bridge {
  static const _bridgePlatform =
      const MethodChannel("com.ym.framework.plugins/bridge");

  static Future<String> dispenser(var dispenser) async {

      String method = dispenser['method'];
      var params = dispenser['params'];
      return await _bridgePlatform.invokeMethod(method, params);

  }

  static Future<String> showShortToast(String message) {
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

  static Future<String> httpRequest(var requestType, String url) async {
    return dispenser({
      "method": "get",
      "params": {"action": "http", "message": url}
    });
  }

  static Future<String> getBatteryLevel() async {
    return dispenser({
      "method": "getBatteryLevel",
      "arguments": {"action": "battery", "message": "msg"}
    });
  }
}
