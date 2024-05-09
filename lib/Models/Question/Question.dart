import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'QuestionMap.dart';

@JsonSerializable()
class QuestionModel {
  QuestionModel(
      {
        this.id=0,
    required this.contenu,
     this.isChecked = false,
   
      });
  int id;
  String? contenu;
  bool isChecked;
  factory QuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}


