import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'UserMap.dart';


@JsonSerializable()
class UserModel {
  UserModel(
      { 
    required this.email,
    required this.password
      });
  String email;
  String? password;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
