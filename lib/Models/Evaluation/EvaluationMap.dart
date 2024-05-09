part of 'Evaluation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


EvaluationModel _$EvaluationFromJson(Map<String, dynamic> json) {
  return EvaluationModel(
    id: json['id'] as int,
     note: json['note'] as double,

  );
}

Map<String, dynamic> _$EvaluationToJson(EvaluationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
   'nom': instance.note,
    };
