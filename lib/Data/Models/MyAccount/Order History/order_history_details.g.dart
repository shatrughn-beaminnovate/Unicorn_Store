// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryDetails _$OrderHistoryDetailsFromJson(Map<String, dynamic> json) =>
    OrderHistoryDetails(
      (json['data'] as List<dynamic>?)
          ?.map((e) => OrderData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderHistoryDetailsToJson(
        OrderHistoryDetails instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
