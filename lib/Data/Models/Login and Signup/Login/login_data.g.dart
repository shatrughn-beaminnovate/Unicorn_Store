// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      json['user_data'] == null
          ? null
          : UserData.fromJson(json['user_data'] as Map<String, dynamic>),
      json['token'] as String?,
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'user_data': instance.userData,
      'token': instance.token,
    };
