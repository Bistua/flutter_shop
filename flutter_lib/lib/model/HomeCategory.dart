
import 'package:json_annotation/json_annotation.dart';
//flutter packages pub run build_runner build
part 'HomeCategory.g.dart';

@JsonSerializable()
class HomeCategory {
  String categoryName;

  String categoryImgUrl;

  int sortNum;
  String categoryId;

  HomeCategory(
      this.categoryName, this.categoryImgUrl, this.sortNum, this.categoryId);

  ///
  factory HomeCategory.fromJson(Map<String, dynamic> json) => _$HomeCategoryFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$CategoryToJson`.
  Map<String, dynamic> toJson() => _$HomeCategoryToJson(this);


}
