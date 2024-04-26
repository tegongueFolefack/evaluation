import 'package:attendance/Models/Enseignant/Enseignant.dart';
import 'package:attendance/Services/server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EnseignantService{
  Future<EnseignantModel> saveEnseignant(EnseignantModel e) async{
    try {
    var url = Uri.parse(AppServer.SAVE_ENS);

    // Ajouter le champ role au corps de la requête
    Map<String, dynamic> requestBody = e.toJson();
    requestBody['role'] = e.role; // Ajouter le rôle au corps de la requête
    
    final response = await http.post(
      url,
      headers: AppServer.headers,
      body: jsonEncode(requestBody),
    );
    
    if (response.statusCode == 200) {
      print(response.body);
      return EnseignantModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Échec de la création de l\'étudiant');
    }
  } catch (e) {
    throw Exception('Une erreur s\'est produite lors de la création de l\'étudiant: $e');
  }
  }

  // Future<dynamic> login(UserModel e) async{
  //   var url = Uri.parse(AppServer.LOGIN);
  //   final response = await http.post(
  //       url,
  //       headers: AppServer.headers,
  //       body:jsonEncode(e.toJson())
  //   );
  //   if (response.statusCode == 200){
  //     print(response.body);
  //     return EnseignantModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  //   }else{
  //     throw Exception('Failed login');
  //   }
  // }

  // Future<dynamic> countEns() async{
  //   var url = Uri.parse(AppServer.LIST_ENS);
  //   final response = await http.get(url, headers:AppServer.headers);
  //   if(response.statusCode == 200){
  //     return jsonDecode(response.body);
  //   }else{
  //     return -1;
  //   }
  // }

  // Future<dynamic> getEns() async{
  //   var url = Uri.parse(AppServer.LIST_ENS);
  //   final response = await http.get(url, headers:AppServer.headers);
  //   if(response.statusCode == 200){
  //     return jsonDecode(response.body);
  //   }else{
  //     return -1;
  //   }
  // }

  // Future<EnseignantModel> updateEns(EnseignantModel etud) async {
  //   final response = await http.put(
  //     Uri.parse(AppServer.UPDATE_ETUDIANT + etud.idEns.toString()),
  //     headers: <String, String>{'Content-Type': 'application/json'},
  //     body: jsonEncode(etud.toJson()),
  //   );
  //   if (response.statusCode == 200){
  //     print(response.body);
  //     return EnseignantModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  //   }else{
  //     throw Exception('Erreur lors de la mise à jour de l\'Enseignant');
  //   }
  // }
}