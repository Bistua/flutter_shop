import 'dart:convert';
import 'dart:io';
import 'package:flutter_lib/model/Banner.dart';

class Http {
  static Future<Images> getBanner() async {
    var url = "https://mall.bchun.com/mall/get/app/index/image";
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);

    String result;
    try {
      var request = await httpClient.postUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var jsons = await response.transform(utf8.decoder).join();
        Images jsonResponse = Images.fromJson(json.decode(jsons));
        return jsonResponse;
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
        return Images.fromJson({"code": response.statusCode, "msg": result});
      }
    } catch (exception) {
      result = exception.toString();
      return Images.fromJson({"code": -1, "msg": result});
    }
  }
}
