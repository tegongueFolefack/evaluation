part of 'RefreshTokenResponse.dart';



RefreshTokenResponseModel _$RefreshTokenResponseFromJson(Map<String, dynamic> json) {
  return RefreshTokenResponseModel(
     refresh_token: json['refresh_Token'] as String,
      access_token: json['access_token'] as String,
      token_type: json['token_type'] as String,

  );
}

Map<String, dynamic> _$RefreshTokenResponseToJson(RefreshTokenResponseModel instance) =>
    <String, dynamic>{
   'refresh_token': instance.refresh_token,
      'access_token': instance.access_token,
        'token_type': instance.token_type,

    };
