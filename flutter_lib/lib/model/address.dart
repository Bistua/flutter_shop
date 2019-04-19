import 'package:flutter/material.dart';
//
//"createTime": "xxxxxxxxxxxx",
//"receiveAddressName": "xxxxxxxxxxxx",
//"receiveGoodsName": "xxxxxxxxxxxx",
//"receivePhone": "xxxxxxxxxxxx",
//"status": "xxxxxxxxxxxx",
//"userAddressId": "xxxxxxxxxxxx",
//"userId": "xxxxxxxxxxxx"

class Address {
  String name;
  String phone;
  String area;
  String address;
  bool isDefault = false;

  Address({this.name, this.phone, this.area, this.address, this.isDefault});
}
