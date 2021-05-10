// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confim_login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmLoginModel _$ConfirmLoginModelFromJson(Map<String, dynamic> json) {
  return ConfirmLoginModel(
    accessToken: json['acces_token'] as String,
    refreshToken: json['refresh_token'] as String,
  );
}

Map<String, dynamic> _$ConfirmLoginModelToJson(ConfirmLoginModel instance) =>
    <String, dynamic>{
      'acces_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
