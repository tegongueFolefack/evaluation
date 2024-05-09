part of 'Epreuve.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


EpreuveModel _$EpreuveFromJson(Map<String, dynamic> json) {
  return EpreuveModel(
    id: json['id'] as int,
     nom: json['nom'] as String,
      contenu: json['contenu'] as String,


  );
}

Map<String, dynamic> _$EpreuveToJson(EpreuveModel instance) =>
    <String, dynamic>{
      'id': instance.id,
   'nom': instance.nom,
      'contenu': instance.contenu,
    };
