// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryInfo _$CategoryInfoFromJson(Map<String, dynamic> json) => CategoryInfo(
      id: json['id'] as int?,
      parent_id: json['parent_id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      route_id: json['route_id'] as int?,
      description: json['description'] as String?,
      excerpt: json['excerpt'] as String?,
      sequence: json['sequence'] as int?,
      image: json['image'] as String?,
      seo_title: json['seo_title'] as String?,
      meta: json['meta'] as String?,
      enabled: json['enabled'] as int?,
      is_navigable: json['is_navigable'] as int?,
      cat_meta: json['cat_meta'] as int?,
      cat_badge: json['cat_badge'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => CategoryInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      accessories: json['accessories'] as bool?,
      watch: json['watch'] as bool?,
    );

Map<String, dynamic> _$CategoryInfoToJson(CategoryInfo instance) =>
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
