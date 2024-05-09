import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'AuthenticationRequestMap.dart';


@JsonSerializable()
class RequestModel {
  RequestModel(
      { 
    required this.email,
    required this.password,
      });
  String email;
  String? password;

  factory RequestModel.fromJson(Map<String, dynamic> json) =>
      _$RequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RequestModelToJson(this);
}
