import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'AuthenticationResponseMap.dart';

@JsonSerializable()
class AuthenticationResponseModel {
  AuthenticationResponseModel(
      {
         this.id=0,
        required this.email,
        required this.roles,
        required this.access_token,
        required this.refresh_token,
        required this.token_type,


   
      });
      int id;
      String email;
      List<String>? roles;
      String access_token;
      String ?refresh_token;
      String token_type;
  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}
