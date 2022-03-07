import 'package:json_annotation/json_annotation.dart';
import 'data.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  List<Data>? data;

  Category({this.data});

  factory Category.fromJson(Map<String, dynamic> category) =>
      _$CategoryFromJson(category);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);


 
}
