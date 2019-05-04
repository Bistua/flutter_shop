import 'dart:async';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/bridge/rebate_bridge.dart';
import 'package:flutter_lib/model/rebateList.dart';

class RebateBloc {
  final rebateStream = StreamController<List<RebateInfo>>();

  Stream<List<RebateInfo>> get rebateInfo {
    return rebateStream.stream;
  }
  RebateBloc();

  getRebatList() {
    RebateBridge.findRebateList(0, 100).then((result) {
      if (result.code == 200) {
        RebateList rebateList = RebateList.fromJson(result.data);
        rebateStream.add(rebateList.list);
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
