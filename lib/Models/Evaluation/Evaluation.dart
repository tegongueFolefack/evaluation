import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'EvaluationMap.dart';

@JsonSerializable()
class EvaluationModel {
  EvaluationModel(
      {
        this.id=0,
       required this.note
      });
  int id;
  double note;
  factory EvaluationModel.fromJson(Map<String, dynamic> json) =>
      _$EvaluationFromJson(json);
  Map<String, dynamic> toJson() => _$EvaluationToJson(this);
}
