import 'package:json_annotation/json_annotation.dart';

part 'confim_login_model.g.dart';

@JsonSerializable()
class ConfirmLoginModel {
  @JsonKey(name: 'acces_token')
  String accessToken;

  @JsonKey(name: 'refresh_token')
  String refreshToken;

  ConfirmLoginModel({
    this.accessToken,
    this.refreshToken,
  });

  factory ConfirmLoginModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmLoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$ConfirmLoginModelToJson(this);
}
