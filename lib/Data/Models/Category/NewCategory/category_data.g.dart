// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      json['id'] as int?,
      json['parent_id'] as int?,
      json['name'] as String?,
      json['slug'] as String?,
      json['route_id'] as int?,
      json['description'] as String?,
      json['excerpt'] as String?,
      json['sequence'] as int?,
      json['image'] as String?,
      json['seo_title'] as String?,
      json['meta'] as String?,
      json['enabled'] as int?,
      json['is_navigable'] as int?,
      json['cat_meta'] as int?,
      json['cat_badge'] as String?,
      (json['children'] as List<dynamic>?)
          ?.map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['accessories'] as bool?,
      json['watch'] as bool?,
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parent_id': instance.parent_id,
      'name': instance.name,
      'slug': instance.slug,
      'route_id': instance.route_id,
      'description': instance.description,
      'excerpt': instance.excerpt,
      'sequence': instance.sequence,
      'image': instance.image,
      'seo_title': instance.seo_title,
      'meta': instance.meta,
      'enabled': instance.enabled,
      'is_navigable': instance.is_navigable,
      'cat_meta': instance.cat_meta,
      'cat_badge': instance.cat_badge,
      'children': instance.children,
      'accessories': instance.accessories,
      'watch': instance.watch,
    };
