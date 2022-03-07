// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      json['id'] as int?,
      json['sequence'] as int?,
      json['name'] as String?,
      json['iso_code_2'] as String?,
      json['iso_code_3'] as String?,
      json['address_format'] as String?,
      json['zip_required'] as int?,
      json['status'] as int?,
      json['tax'] as int?,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'sequence': instance.sequence,
      'name': instance.name,
      'iso_code_2': instance.isoCode2,
      'iso_code_3': instance.isoCode3,
      'address_format': instance.addressFormat,
      'zip_required': instance.zipRequired,
      'status': instance.status,
      'tax': instance.tax,
    };
