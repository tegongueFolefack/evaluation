part of 'Enseignant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


EnseignantModel _$EnseignantFromJson(Map<String, dynamic> json) {
  return EnseignantModel(
      nom: json['nom'] as String,
      prenom: json['prenom'] as String,
      email: json['email'] as String,
     password: json['password'] as String,
      login: json['login'] as String,
      telephone: json['telephone'] as int,
  );
}

Map<String, dynamic> _$EnseignantToJson(EnseignantModel instance) =>
    <String, dynamic>{
   'nom': instance.nom,
      'prenom': instance.prenom,
      'email': instance.email,
      'password': instance.password,
      'login': instance.login,
      'telephone': instance.telephone,
    };
