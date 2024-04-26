import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'UserMap.dart';

@JsonSerializable()
class UserModel {
  UserModel(
      {   required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.login,
    required this.telephone,
    this.role="ETUDIANT"
      });
  String nom;
  String? prenom;
  String email;
  String? password;
  String login;
  int telephone;
  String role;


  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
