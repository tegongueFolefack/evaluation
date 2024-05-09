part of 'RefreshTokenRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


RefreshTokenRequestModel _$RefreshTokenRequestFromJson(Map<String, dynamic> json) {
  return RefreshTokenRequestModel(
     refreshToken: json['refreshToken'] as String,

  );
}

Map<String, dynamic> _$RefreshTokenRequestToJson(RefreshTokenRequestModel instance) =>
    <String, dynamic>{
   'refreshToken': instance.refreshToken,
    };
