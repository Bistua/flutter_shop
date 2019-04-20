import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// This allows the `Category` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'category.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class Category {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'thumbnail')
  String image;

  Category({this.id, this.name, this.image});


  /// A necessary factory constructor for creating a new Category instance
  /// from a map. Pass the map to the generated `_$CategoryFromJson()` constructor.
  /// The constructor is named after the source class, in this case Category.
  ///
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$CategoryToJson(this);



}
