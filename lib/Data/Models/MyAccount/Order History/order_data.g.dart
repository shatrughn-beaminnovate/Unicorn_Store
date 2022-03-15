// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => OrderData(
      json['id'] as int?,
      json['order_number'] as int?,
      json['status'] as String?,
      json['ordered_on'] as String?,
      json['total'] as int?,
      (json['ordered_product'] as List<dynamic>?)
          ?.map((e) => OrderItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
      'id': instance.id,
      'order_number': instance.orderNumber,
      'status': instance.status,
      'ordered_on': instance.orderedOn,
      'total': instance.total,
      'ordered_product': instance.orderedProduct,
    };
