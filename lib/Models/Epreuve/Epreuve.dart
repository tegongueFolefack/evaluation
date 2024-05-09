import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'EpreuveMap.dart';

@JsonSerializable()
class EpreuveModel {
  EpreuveModel(
      {
        this.id=0,
       required this.nom,
    required this.contenu,
   
      });
  int id;
  String nom;
  String? contenu;
  factory EpreuveModel.fromJson(Map<String, dynamic> json) =>
      _$EpreuveFromJson(json);
  Map<String, dynamic> toJson() => _$EpreuveToJson(this);
}
