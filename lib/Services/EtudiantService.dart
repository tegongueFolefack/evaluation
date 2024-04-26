import 'package:attendance/Services/server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/Etudiant/Etudiant.dart';
class EtudiantService{
  

  Future<EtudiantModel> saveEtudiant(EtudiantModel e) async {
  try {
    var url = Uri.parse(AppServer.SAVE_ETUDIANT);
    
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
      return EtudiantModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Échec de la création de l\'étudiant');
    }
  } catch (e) {
    throw Exception('Une erreur s\'est produite lors de la création de l\'étudiant: $e');
  }
}

// Méthode pour récupérer un étudiant par son ID
  Future<EtudiantModel> getEtudiantById(int id) async {
    try {
      var url = Uri.parse("${AppServer.GET_ONE_ETUDIANT}$id");
      final response = await http.get(url, headers: AppServer.headers);
      if (response.statusCode == 200) {
        return EtudiantModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Impossible de récupérer l\'étudiant');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite lors de la récupération de l\'étudiant: $e');
    }
  }

  // Méthode pour mettre à jour un étudiant
  Future<void> updateEtudiant(int id, EtudiantModel etudiant) async {
    try {
      var url = Uri.parse("${AppServer.UPDATE_ETUDIANT}/$id");
      final response = await http.put(
        url,
        headers: AppServer.headers,
        body: jsonEncode(etudiant.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Échec de la mise à jour de l\'étudiant');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite lors de la mise à jour de l\'étudiant: $e');
    }
  }

  // Méthode pour supprimer un étudiant
  Future<void> deleteEtudiant(int id) async {
    try {
      var url = Uri.parse("${AppServer.DELETE_ETUDIANT}$id");
      final response = await http.delete(
        url,
        headers: AppServer.headers,
      );
      if (response.statusCode != 204) {
        throw Exception('Échec de la suppression de l\'étudiant');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite lors de la suppression de l\'étudiant: $e');
    }
  }

  Future<List<EtudiantModel>> getEtudiants() async {
    try {
      var url = Uri.parse(AppServer.LIST_ETUDIANT);
      final response = await http.get(url, headers: AppServer.headers);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<EtudiantModel> etudiants = jsonData.map((e) => EtudiantModel.fromJson(e as Map<String, dynamic>)).toList();
        return etudiants;
      } else {
        throw Exception('Échec de la récupération des étudiants');
      }
    } catch (e) {
      throw Exception('Une erreur s\'est produite lors de la récupération des étudiants: $e');
    }
  }

  
}