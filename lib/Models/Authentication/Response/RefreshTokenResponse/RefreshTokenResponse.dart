import "dart:core";
import 'package:json_annotation/json_annotation.dart';
part 'RefreshTokenResponseMap.dart';


@JsonSerializable()
class RefreshTokenResponseModel {
  RefreshTokenResponseModel(
      {
         this.id=0,
        required this.access_token,
        required this.refresh_token,
        required this.token_type,


   
      });
      int id;
      String access_token;
      String refresh_token;
      String token_type;
  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshTokenResponseToJson(this);
}
