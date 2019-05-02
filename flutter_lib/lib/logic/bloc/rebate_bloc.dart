import 'dart:async';
import 'package:flutter_lib/bridge/common_bridge.dart';
import 'package:flutter_lib/model/rebate_list.dart';
import 'package:flutter_lib/bridge//rebate_bridge.dart';

/*
 * 返现记录
 */
class RebateInfoBloc {
  final rebateInfoStream = StreamController<RebateList>();

  Stream<RebateList> get rebateInfo {
    return rebateInfoStream.stream;
  }

  RebateInfoBloc();
  /*
   *获取返现记录列表
   */
  getRebateList(){
    RebateBridge.findRebateList(0, 1000).then((result){
      if (result.code == 200) {
        RebateList rebateinfos = RebateList.fromJson(result.data);
        rebateInfoStream.add(rebateinfos);
      } else {
        Bridge.showLongToast(result.msg == null ? "未返回错误信息" : result.msg);
      }
    });
  }

  close() {
    if (rebateInfoStream != null) {
      rebateInfoStream.close();
    }
  }
}

