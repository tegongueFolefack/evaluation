part of 'Matiere.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


MatiereModel _$MatiereFromJson(Map<String, dynamic> json) {
  return MatiereModel(
    id: json['id'] as int,
     label: json['label'] as String,
      credit: json['credit'] as int,

  );
}

Map<String, dynamic> _$MatiereToJson(MatiereModel instance) =>
    <String, dynamic>{
      'id': instance.id,
   'label': instance.label,
      'credit': instance.credit,
    };
