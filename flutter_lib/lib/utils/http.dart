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

  static Future<List<DataListBean>> getBanner() async {
    Result result = await getResult(baseUrl + banner);
    if (result != null && result.code == 0) {
      dynamic data = result.data;
      List<dynamic> l = data["list"];
      List<DataListBean> c = l.map((f){
        return DataListBean.fromJson(f);
      }).toList();
      print(data);
      return c;
    }
    return null;
  }

  static Future<List<HomeCategory>> getHomeCategoryList() async {
    Result result = await getResult(baseUrl + homeCategory);
    if (result != null && result.code == 0) {
      dynamic data = result.data;
      List<dynamic> l = data["list"];
      List<HomeCategory> c = l.map((f){
        return HomeCategory.fromJson(f);
      }).toList();
      print(data);
      return c;
    }
    return null;
  }
}
