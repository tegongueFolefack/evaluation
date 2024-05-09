part of 'Question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


QuestionModel _$QuestionFromJson(Map<String, dynamic> json) {
  return QuestionModel(
    id: json['id'] as int,
      contenu: json['contenu'] as String,

  );
}

Map<String, dynamic> _$QuestionToJson(QuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contenu': instance.contenu,
    };
