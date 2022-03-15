// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItems _$OrderItemsFromJson(Map<String, dynamic> json) => OrderItems(
      json['id'] as int?,
      json['order_id'] as int?,
      json['product_id'] as int?,
      json['quantity'] as int?,
      json['contents'] == null
          ? null
          : OrderProductData.fromJson(json['contents'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderItemsToJson(OrderItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'contents': instance.contents,
    };
