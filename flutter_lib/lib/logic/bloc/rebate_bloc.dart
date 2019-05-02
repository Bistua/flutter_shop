import 'dart:async';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/account_bridge.dart';
import 'package:flutter_lib/model/rebateList.dart';

class RebateBloc {
  final rebateStream = StreamController<RebateList>();

  Stream<RebateList> get rebateInfo {
    return rebateStream.stream;
  }

  RebateBloc();

  getUserInfo() {
    AccountBridge.getUserInfo().then((result) {
      if (result.code == 200) {
        RebateList userinfo = RebateList.fromJson(result.data);
        rebateStream.add(userinfo);
      } else {
        Bridge.showLongToast(result.msg == null ? "未返回错误信息" : result.msg);
      }
    });
  }

  close() {
    if (rebateStream != null) {
        rebateStream.close();
    }
  }
}
