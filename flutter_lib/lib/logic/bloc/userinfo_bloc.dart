import 'dart:async';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/account_bridge.dart';
import 'package:flutter_lib/model/userinfo.dart';

class UserInfoBloc {
  final userInfoStream = StreamController<Userinfo>();

  Stream<Userinfo> get userInfo {
    return userInfoStream.stream;
  }

  UserInfoBloc();

  getUserInfo() {
    AccountBridge.getUserInfo().then((result) {
      if (result.code == 200) {
        Userinfo userinfo = Userinfo.fromJson(result.data);
        userInfoStream.add(userinfo);
      } else {
//        Bridge.showLongToast(result.msg == null ? "未返回错误信息" : result.msg);
      }
    });
  }

  close() {
    if (userInfoStream != null) {
      userInfoStream.close();
    }
  }
}

