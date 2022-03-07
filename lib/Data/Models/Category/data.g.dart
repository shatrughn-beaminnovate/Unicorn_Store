// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
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
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'parent_id': instance.parentId,
      'name': instance.name,
      'slug': instance.slug,
      'route_id': instance.routeId,
      'description': instance.description,
      'excerpt': instance.excerpt,
      'sequence': instance.sequence,
      'image': instance.image,
      'seo_title': instance.seoTitle,
      'meta': instance.meta,
      'enabled': instance.enabled,
      'is_navigable': instance.isNavigable,
      'cat_meta': instance.catMeta,
      'cat_badge': instance.catBadge,
    };
