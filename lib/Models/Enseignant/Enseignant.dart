import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'EnseignantMap.dart';


@JsonSerializable()
class EnseignantModel {
  EnseignantModel(
      { required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.login,
    required this.telephone,
    this.role="ENSEIGNANT"
      });
  String nom;
  String? prenom;
  String email;
  String? password;
  String login;
  int telephone;
  String role;

  factory EnseignantModel.fromJson(Map<String, dynamic> json) =>
      _$EnseignantFromJson(json);
  Map<String, dynamic> toJson() => _$EnseignantToJson(this);
}
