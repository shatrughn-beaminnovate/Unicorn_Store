// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductData _$OrderProductDataFromJson(Map<String, dynamic> json) =>
    OrderProductData(
      json['id'] as int?,
      json['name'] as String?,
      json['saleprice'] as int?,
      (json['images'] as List<dynamic>)
          .map((e) => TypeImages.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderProductDataToJson(OrderProductData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'saleprice': instance.saleprice,
      'images': instance.images,
    };
