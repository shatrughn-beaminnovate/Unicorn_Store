// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductTypeDetails _$ProductTypeDetailsFromJson(Map<String, dynamic> json) =>
    ProductTypeDetails(
      json['data'] == null
          ? null
          : ProductDetails.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductTypeDetailsToJson(ProductTypeDetails instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
