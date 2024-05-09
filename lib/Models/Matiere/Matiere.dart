import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'MatiereMap.dart';

@JsonSerializable()
class MatiereModel {
  MatiereModel(
      {
        this.id=0,
       required this.label,
    required this.credit,
   
      });
  int id;
  String label;
  int? credit;
  factory MatiereModel.fromJson(Map<String, dynamic> json) =>
      _$MatiereFromJson(json);
  Map<String, dynamic> toJson() => _$MatiereToJson(this);
}
