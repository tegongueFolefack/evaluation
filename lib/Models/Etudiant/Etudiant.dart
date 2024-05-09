import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'EtudiantMap.dart';

@JsonSerializable()
class EtudiantModel {
  EtudiantModel(
      {
        this.id=0,
       required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.login,
    required this.telephone,
    this.role="ETUDIANT"
      });
  int id;
  String nom;
  String? prenom;
  String email;
  String? password;
  String login;
  int telephone;
  String role;

  factory EtudiantModel.fromJson(Map<String, dynamic> json) =>
      _$EtudiantFromJson(json);
  Map<String, dynamic> toJson() => _$EtudiantToJson(this);
}
