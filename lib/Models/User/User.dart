import "dart:core";
import 'package:attendance/Models/User/Role.dart';
import 'package:json_annotation/json_annotation.dart';
part 'UserMap.dart';

@JsonSerializable()
class UserModel {
  UserModel(
      { 
        this.id=0,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.login,
    required this.telephone,
    required this.role,
      });
      int id;
  String nom;
  String? prenom;
  String email;
  String? password;
  String login;
  int telephone;
  Role role;


  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
