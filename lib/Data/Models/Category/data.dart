
import 'package:json_annotation/json_annotation.dart';
part 'data.g.dart';

@JsonSerializable()
class Data
{
  final int? id;

  @JsonKey(name: "parent_id")
  final int? parentId;
  final String? name;
  final String? slug;

  @JsonKey(name: "route_id")
  final int? routeId;
  final String? description;
  final String? excerpt;
  final int? sequence;
  final String? image;

  @JsonKey(name:"seo_title")
  final String? seoTitle;
  final String? meta;
  final int? enabled;

  @JsonKey(name:"is_navigable")
  final int? isNavigable;

  @JsonKey(name:"cat_meta")
  final int? catMeta;

  @JsonKey(name:"cat_badge")
  final String? catBadge;



  factory Data.fromJson(Map<String, dynamic> data) =>
      _$DataFromJson(data);

  Data(this.id, this.parentId, this.name, this.slug, this.routeId, this.description, this.excerpt, this.sequence, this.image, this.seoTitle, this.meta, this.enabled, this.isNavigable, this.catMeta, this.catBadge);
  Map<String, dynamic> toJson() => _$DataToJson(this);

  @override
  String toString() {
    return 'Data $name';
  }

}