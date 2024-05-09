part of 'AuthenticationResponse.dart';



AuthenticationResponseModel _$AuthenticationResponseFromJson(Map<String, dynamic> json) {
  return AuthenticationResponseModel(
     id: json['id'] as int,
    email: json['email'] as String,
   refresh_token: json['refresh_token'] == null ? "null" : json['refresh_token'] as String?,
    roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
    access_token: json['access_token'] as String,
    token_type: json['token_type'] as String,

  );
}

Map<String, dynamic> _$AuthenticationResponseToJson(AuthenticationResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
   'refresh_token': instance.refresh_token,
      'roles': instance.roles,
      'access_token': instance.access_token,
        'token_type': instance.token_type,

    };
