import 'package:flutter_lib/model/address.dart';

class AddressList {
  List<Address> list;

  AddressList({this.list});

  factory AddressList.fromJson(dynamic result) {
    print("AddressList");
    print(result);
    List<dynamic> parsedJson = result["list"];
    var list = parsedJson.map((i) => Address.fromJson(i)).toList();
    return new AddressList(
      list: list,
    );
  }
}
