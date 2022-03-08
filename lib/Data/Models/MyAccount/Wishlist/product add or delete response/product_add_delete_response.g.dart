// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_add_delete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAddDeleteResponse _$ProductAddDeleteResponseFromJson(
        Map<String, dynamic> json) =>
    ProductAddDeleteResponse(
      json['data'] == null
          ? null
          : ProductAddDeleteData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductAddDeleteResponseToJson(
        ProductAddDeleteResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
