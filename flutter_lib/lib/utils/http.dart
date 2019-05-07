import 'dart:convert';
import 'dart:io';
import 'package:flutter_lib/model/Banner.dart';
import 'package:flutter_lib/model/HomeCategory.dart';
import 'package:flutter_lib/model/Result.dart';

class Http {
  static const baseUrl = "https://mall.bchun.com";

  static const banner = "/mall/get/app/index/image";

  static const homeCategory = "/mall/get/app/index/category";

  static Future<Result> getResult(String url) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);

    String result;
    try {
      print(url);
      var request = await httpClient.postUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var jsons = await response.transform(utf8.decoder).join();
        Result jsonResponse = Result.fromJson(jsons);

        print("http:response:"+jsonResponse.toString());
        return jsonResponse;
      } else {
        result =
            'Error getting IP address:\nHttp status ${response.statusCode}';
        return Result.fromJson(
            json.encode({"code": response.statusCode, "msg": result}));
      }
    } catch (exception) {
      result = exception.toString();
      return Result.fromJson(json.encode({"code": -1, "msg": result}));
    }
  }

  static Future<Images> getBanner() async {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);

    String result;
    try {
      var request = await httpClient.postUrl(Uri.parse(baseUrl + banner));
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

  static Future<List<HomeCategory>> getHomeCategoryList() async {
    Result result = await getResult(baseUrl + homeCategory);
    if (result != null && result.code == 200) {
      List<dynamic> data = result.data;
      print(data);
      return null;
    }
    return null;
  }
}
