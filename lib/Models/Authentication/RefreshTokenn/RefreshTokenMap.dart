part of 'RefreshToken.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************



RefreshTokenModel _$RefreshTokenFromJson(Map<String, dynamic> json) {
  return RefreshTokenModel(
    id: json['id'] as int,
      token: json['token'] as String,
      expiryDate: json['expiryDate'] as DateTime,
      revoked: json['revoked'] as bool,
      user: json['user'] as UserModel,

  );
}

Map<String, dynamic> _$RefreshTokenToJson(RefreshTokenModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'expiryDate': instance.expiryDate,
      'revoked': instance.revoked,
      'user': instance.user,

    };
