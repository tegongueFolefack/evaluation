import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'SalleMap.dart';

@JsonSerializable()
class SalleModel {
  SalleModel(
      {required this.codeSalle,
        required this.nbrePlace,
        this.idSalle
      });
  String codeSalle;
  int? idSalle;
  int nbrePlace;

  factory SalleModel.fromJson(Map<String, dynamic> json) =>
      _$SalleFromJson(json);
  Map<String, dynamic> toJson() => _$SalleToJson(this);
}
