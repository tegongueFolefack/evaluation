part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


UserModel _$UserFromJson(Map<String, dynamic> json) {
  return UserModel(
      email: json['email'] as String,
     password: json['password'] as String
  );
}

Map<String, dynamic> _$UserToJson(UserModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password
    };
