// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_add_delete_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductAddDeleteResponse _$ProductAddDeleteResponseFromJson(
        Map<String, dynamic> json) =>
    ProductAddDeleteResponse(
      json['productAddDeleteData'] == null
          ? null
          : ProductAddDeleteData.fromJson(
              json['productAddDeleteData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductAddDeleteResponseToJson(
        ProductAddDeleteResponse instance) =>
    <String, dynamic>{
      'productAddDeleteData': instance.productAddDeleteData,
    };
