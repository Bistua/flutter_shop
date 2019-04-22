import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  @JsonKey(name: 'receiveGoodsName')
  String name;
  @JsonKey(name: 'receivePhone')
  String phone;
  @JsonKey(name: 'userAddressId')
  String userAddressId;
  @JsonKey(name: 'receiveAddressName')
  String address;
  @JsonKey(name: 'status')
  int status;

  Address(
      {this.name, this.phone, this.userAddressId, this.address, this.status});

  /// A necessary factory constructor for creating a new Category instance
  /// from a map. Pass the map to the generated `_$CategoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case Category.
  ///
  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}
