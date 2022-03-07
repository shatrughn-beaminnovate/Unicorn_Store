// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_page_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPageDetail _$ProductPageDetailFromJson(Map<String, dynamic> json) =>
    ProductPageDetail(
      Product.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductPageDetailToJson(ProductPageDetail instance) =>
    <String, dynamic>{
      'data': instance.product,
    };
