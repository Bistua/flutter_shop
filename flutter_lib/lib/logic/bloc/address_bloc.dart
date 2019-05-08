import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_lib/bridge/address_bridge.dart';
import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/model/addresslist.dart';
import 'package:flutter_lib/utils/uidata.dart';

class AddressBloc {
  final addressController = StreamController<List<Address>>();

  Stream<List<Address>> get productItems {
    return addressController.stream;
  }

  AddressBloc();

  getAddressList(BuildContext context) {
    AddressBridge.findAddress(1, 2000).then((result) {
      if (result.code == 200) {
        AddressList categoryList = AddressList.fromJson(result.data);
        addressController.add(categoryList.list);
      } else {
        print(result.msg == null ? "未返回错误信息" : result.msg);
        if (result.code == 401) {
          Navigator.pushNamed(context, UIData.login);
        }
        addressController.add(List());
      }
    });
  }
}
