import 'package:json_annotation/json_annotation.dart';

/// This allows the `Category` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
///
///在flutter_lib 下使用命令 flutter packages pub run build_runner build
///下面两个报错引用的是  category.g.dart 中生成的代码
///生成category.dart的另一部分 category.g.dart
part 'category.g.dart';

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

  @override
  String toString() {
    return 'Category{id: $id, name: $name, image: $image}';
  }


}
