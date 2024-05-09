
import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'EnseignantMap.dart';


@JsonSerializable()
class EnseignantModel {
  EnseignantModel(
      { 
    this.id=0,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.login,
    required this.telephone,
    required this.datePriseEns,
    this.role="ENSEIGNANT"
      });
  int id;
  String nom;
  String? prenom;
  String email;
  String? password;
  String login;
  String telephone;
  String datePriseEns;
  String role;

  factory EnseignantModel.fromJson(Map<String, dynamic> json) =>
      _$EnseignantFromJson(json);
  Map<String, dynamic> toJson() => _$EnseignantToJson(this);
}
