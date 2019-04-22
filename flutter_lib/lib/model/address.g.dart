// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
      name: json['receiveGoodsName'] as String,
      phone: json['receivePhone'] as String,
      userAddressId: json['userAddressId'] as String,
      address: json['receiveAddressName'] as String,
      status: json['status'] as int);
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'receiveGoodsName': instance.name,
      'receivePhone': instance.phone,
      'userAddressId': instance.userAddressId,
      'receiveAddressName': instance.address,
      'status': instance.status
    };
