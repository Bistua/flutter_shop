import 'package:flutter_lib/model/address.dart';
import 'package:flutter_lib/model/product.dart';

class AddressManager {
  factory AddressManager() => _getInstance();

  static AddressManager get instance => _getInstance();
  static AddressManager _instance;

  static AddressManager _getInstance() {
    if (_instance == null) {
      _instance = new AddressManager._internal();
    }
    return _instance;
  }

  AddressManager._internal() {
    // 初始化
  }

  List<Address> addresss = new List();

  int size() {
    return addresss.length;
  }

  void addAddress(Address address) {
    //todo 检查地址是否重复
    //todo 检查地址是否设为默认，若被设为默认，取消其它默认
    addresss.add(address);
  }

  void remove(Address product) {}

  void setDefault(Address product) {
    product.status = 1;
  }

  Address getDefaultAddress() {
    addresss.forEach((f) {
      if (f.status == 1) {
        return f;
      }
    });
    if (addresss.isNotEmpty) {
      return addresss[0];
    } else {
      return null;
    }
  }

  List<Address> getAddresss() {
    return addresss;
  }
}
