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

  // Méthode pour récupérer un étudiant par son ID
  Future<EnseignantModel> getEnseignantById(int id) async {
    try {
      var url = Uri.parse("${AppServer.GET_ONE_ENS}$id");
      final response = await http.get(url, headers: AppServer.headers);
      if (response.statusCode == 200) {
        return EnseignantModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Impossible de récupérer l\'énseignant');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  // Méthode pour mettre à jour un étudiant
  Future<void> updateEnseignant(int id, EnseignantModel Enseignant) async {
    try {
      var url = Uri.parse("${AppServer.UPDATE_ENS}/$id");
      final response = await http.put(
        url,
        headers: AppServer.headers,
        body: jsonEncode(Enseignant.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Échec de la mise à jour de l\'étudiant');
      }
    } catch (e) {
      throw Exception(' $e');
    }
  }

  // Méthode pour supprimer un étudiant
  Future<void> deleteEnseignant(int id) async {
    try {
      var url = Uri.parse("${AppServer.DELETE_ENS}$id");
      final response = await http.delete(
        url,
        headers: AppServer.headers,
      );
      if (response.statusCode != 204) {
        throw Exception('Échec de la suppression de l\'étudiant');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<List<EnseignantModel>> getEnseignants() async {
  var url = Uri.parse(AppServer.LIST_ENS);
  try {
    final response = await http.get(url, headers: AppServer.headers);
    if (response.statusCode == 200) {
      // Convertir le corps de la réponse en une liste JSON
      final List<dynamic> jsonData = json.decode(response.body);
      
      // Afficher les données JSON dans la console
      print(jsonData); 
      
      // Afficher le corps de la réponse dans la console
      print(response.body);
      
      // Créer une liste d'objets EnseignantModel à partir des données JSON
      List<EnseignantModel> Enseignants = jsonData.map((e) => EnseignantModel.fromJson(e as Map<String, dynamic>)).toList();
      
     
      
      // Retourner la liste des étudiants
      return Enseignants;
    } else {
      throw Exception('Échec de la récupération des Enseignant: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception(' $e');
  }
}
}