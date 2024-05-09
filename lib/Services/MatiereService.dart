
import 'package:attendance/Services/server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/Matiere/Matiere.dart';
class MatiereService{
  
  
  Future<MatiereModel> saveMatiere(MatiereModel e) async {
  try {
    var url = Uri.parse(AppServer.SAVE_MAT);
    Map<String, dynamic> requestBody = e.toJson();
    
    final response = await http.post(
      url,
      headers: AppServer.headers,
      body: jsonEncode(requestBody),
    );
    
    if (response.statusCode == 200) {
      print(response.body);
      return MatiereModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Échec de la création de l\'étudiant');
    }
  } catch (e) {
    throw Exception('$e');
  }
}

// Méthode pour récupérer un étudiant par son ID
  Future<MatiereModel> getMatiereById(int id) async {
    try {
      var url = Uri.parse("${AppServer.GET_ONE_MAT}$id");
      final response = await http.get(url, headers: AppServer.headers);
      if (response.statusCode == 200) {
        return MatiereModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Impossible de récupérer l\'étudiant');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  // Méthode pour mettre à jour un étudiant
  Future<void> updateMatiere(int id, MatiereModel Matiere) async {
    try {
      var url = Uri.parse("${AppServer.UPDATE_MAT}/$id");
      final response = await http.put(
        url,
        headers: AppServer.headers,
        body: jsonEncode(Matiere.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Échec de la mise à jour de l\'étudiant');
      }
    } catch (e) {
      throw Exception(' $e');
    }
  }

  // Méthode pour supprimer un étudiant
  Future<void> deleteMatiere(int id) async {
    try {
      var url = Uri.parse("${AppServer.DELETE_MAT}$id");
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

  Future<List<MatiereModel>> getMatieres() async {
  var url = Uri.parse(AppServer.LIST_MAT);
  try {
    final response = await http.get(url, headers: AppServer.headers);
    if (response.statusCode == 200) {
      // Convertir le corps de la réponse en une liste JSON
      final List<dynamic> jsonData = json.decode(response.body);
      
      // Afficher les données JSON dans la console
      print(jsonData); 
      
      // Afficher le corps de la réponse dans la console
      print(response.body);
      
      // Créer une liste d'objets MatiereModel à partir des données JSON
      List<MatiereModel> Matieres = jsonData.map((e) => MatiereModel.fromJson(e as Map<String, dynamic>)).toList();
      
     
      
      // Retourner la liste des étudiants
      return Matieres;
    } else {
      throw Exception('Échec de la récupération des étudiants: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception(' $e');
  }
}


  
}