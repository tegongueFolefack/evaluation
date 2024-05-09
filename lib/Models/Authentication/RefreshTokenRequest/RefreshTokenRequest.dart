import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'RefreshTokenRequestMap.dart';

@JsonSerializable()
class RefreshTokenRequestModel {
  RefreshTokenRequestModel(
      {
       required this.refreshToken,
   
      });
  String refreshToken;
  factory RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
