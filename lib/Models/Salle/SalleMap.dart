part of 'Salle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


SalleModel _$SalleFromJson(Map<String, dynamic> json) {
  return SalleModel(
      codeSalle: json['codeSalle'] as String,
      nbrePlace: json['nbrePlace'] as int,
    idSalle: json['idSalle'] as int
  );
}

Map<String, dynamic> _$SalleToJson(SalleModel instance) =>
    <String, dynamic>{
      'codeSalle': instance.codeSalle,
      'nbrePlace': instance.nbrePlace,
      'idSalle': instance.idSalle
    };
