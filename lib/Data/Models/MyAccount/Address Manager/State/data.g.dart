// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateData _$StateDataFromJson(Map<String, dynamic> json) => StateData(
      json['id'] as int?,
      json['country_id'] as int?,
      json['code'] as String?,
      json['name'] as String?,
      json['status'] as int?,
      json['tax'] as int?,
    );

Map<String, dynamic> _$StateDataToJson(StateData instance) => <String, dynamic>{
      'id': instance.id,
      'country_id': instance.countryId,
      'code': instance.code,
      'name': instance.name,
      'status': instance.status,
      'tax': instance.tax,
    };
