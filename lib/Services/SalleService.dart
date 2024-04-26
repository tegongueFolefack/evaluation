// import 'package:attendance/Models/Enseignant/Enseignant.dart';
// import 'package:attendance/Models/Salle/Salle.dart';
// import 'package:attendance/Services/server.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class SalService{
//   Future<SalleModel> saveEtudiant(SalleModel e) async{
//     var url = Uri.parse(AppServer.SAVE_SALLE);
//     final response = await http.post(
//         url,
//         headers: AppServer.headers,
//         body:jsonEncode(e.toJson())
//     );
//     if (response.statusCode == 200){
//       print(response.body);
//       return SalleModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//     }else{
//       throw Exception('Failed to create student');
//     }
//   }

//   Future<dynamic> countEns() async{
//     var url = Uri.parse(AppServer.LIST_SALLE);
//     final response = await http.get(url, headers:AppServer.headers);
//     if(response.statusCode == 200){
//       return jsonDecode(response.body);
//     }else{
//       return -1;
//     }
//   }

//   Future<dynamic> getEns() async{
//     var url = Uri.parse(AppServer.LIST_SALLE);
//     final response = await http.get(url, headers:AppServer.headers);
//     if(response.statusCode == 200){
//       return jsonDecode(response.body);
//     }else{
//       return -1;
//     }
//   }

//   Future<SalleModel> updateEns(SalleModel etud) async {
//     final response = await http.put(
//       Uri.parse(AppServer.UPDATE_SALLE + etud.idSalle.toString()),
//       headers: <String, String>{'Content-Type': 'application/json'},
//       body: jsonEncode(etud.toJson()),
//     );
//     if (response.statusCode == 200){
//       print(response.body);
//       return SalleModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//     }else{
//       throw Exception('Erreur lors de la mise à jour de l\'Enseignant');
//     }
//   }

//   Future<SalleModel> getOne(int etud) async {
//     final response = await http.get(
//       Uri.parse(AppServer.GET_ONE_SALLE + etud.toString()),
//       headers: <String, String>{'Content-Type': 'application/json'},
//     );
//     if (response.statusCode == 200){
//       print(response.body);
//       return SalleModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//     }else{
//       throw Exception('Erreur lors de la mise à jour de l\'Enseignant');
//     }
//   }

//   Future<dynamic> getOneByEns(int etud) async {
//     final response = await http.get(
//       Uri.parse(AppServer.GET_ONE_SALLE_BY_ENS + etud.toString()),
//       headers: <String, String>{'Content-Type': 'application/json'},
//     );
//     if (response.statusCode == 200){
//       print(response.body);
//       return SalleModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//     }else{
//       throw Exception('Erreur lors de la mise à jour de l\'Enseignant');
//     }
//   }
// }