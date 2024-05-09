
import "dart:core";
import 'package:attendance/Models/User/User.dart';
import 'package:json_annotation/json_annotation.dart';
part 'RefreshTokenMap.dart';

@JsonSerializable()
class RefreshTokenModel {
  RefreshTokenModel(
      {
        this.id=0,
    required this.token,
    required this.expiryDate,
    required this.revoked,
    required this.user,

   
      });
  int id;
  String token;
  DateTime expiryDate;
  bool revoked;
  UserModel user;
  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshTokenToJson(this);
}