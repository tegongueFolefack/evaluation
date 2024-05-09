
import 'package:attendance/Models/Question/Question.dart';
import 'package:attendance/Services/server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/Epreuve/Epreuve.dart';
class EpreuveService{
  
  
  Future<EpreuveModel> saveEpreuve(EpreuveModel e) async {
  try {
    var url = Uri.parse(AppServer.SAVE_EPREUVE);
    Map<String, dynamic> requestBody = e.toJson();
    
    final response = await http.post(
      url,
      headers: AppServer.headers,
      body: jsonEncode(requestBody),
    );
    
    if (response.statusCode == 200) {
      print(response.body);
      return EpreuveModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Échec de la création de l\'étudiant');
    }
  } catch (e) {
    throw Exception('$e');
  }
}

// Méthode pour récupérer un étudiant par son ID
  Future<EpreuveModel> getEpreuveById(int id) async {
    try {
      var url = Uri.parse("${AppServer.GET_ONE_EPREUVE}$id");
      final response = await http.get(url, headers: AppServer.headers);
      if (response.statusCode == 200) {
        return EpreuveModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Impossible de récupérer l\'étudiant');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  // Méthode pour mettre à jour un étudiant
  Future<void> updateEpreuve(int id, EpreuveModel Epreuve) async {
    try {
      var url = Uri.parse("${AppServer.UPDATE_EPREUVE}/$id");
      final response = await http.put(
        url,
        headers: AppServer.headers,
        body: jsonEncode(Epreuve.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Échec de la mise à jour de l\'étudiant');
      }
    } catch (e) {
      throw Exception(' $e');
    }
  }

  // Méthode pour supprimer un étudiant
  Future<void> deleteEpreuve(int id) async {
    try {
      var url = Uri.parse("${AppServer.DELETE_EPREUVE}$id");
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

  Future<List<EpreuveModel>> getEpreuves() async {
  var url = Uri.parse(AppServer.LIST_EPREUVE);
  try {
    final response = await http.get(url, headers: AppServer.headers);
    if (response.statusCode == 200) {
      // Convertir le corps de la réponse en une liste JSON
      final List<dynamic> jsonData = json.decode(response.body);
      
      // Afficher les données JSON dans la console
      print(jsonData); 
      
      // Afficher le corps de la réponse dans la console
      print(response.body);
      
      // Créer une liste d'objets EpreuveModel à partir des données JSON
      List<EpreuveModel> Epreuves = jsonData.map((e) => EpreuveModel.fromJson(e as Map<String, dynamic>)).toList();
      
     
      
      // Retourner la liste des étudiants
      return Epreuves;
    } else {
      throw Exception('Échec de la récupération des étudiants: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception(' $e');
  }
}

 
  Future<List<QuestionModel>> getQuestionsByEpreuveId(int epreuveId) async {
    try {
      var url = Uri.parse("${AppServer.GET_QUESTION}$epreuveId");
      final response = await http.get(url, headers: AppServer.headers);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        List<QuestionModel> questions = jsonData.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>)).toList();
        return questions;
      } else {
        throw Exception('Impossible de récupérer les questions de l\'épreuve: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

   Future<String> addQuestionToEpreuve(int epreuveId, int questionId) async {
    try {
      var url = Uri.parse(AppServer.ADD_QUESTION_TO_EPREUVE);
      var requestBody = jsonEncode({
        'epreuveId': epreuveId,
        'questionId': questionId,
      });

      final response = await http.post(
        url,
        headers: AppServer.headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        return 'success';
      } else {
        return 'error: ${response.body}';
      }
    } catch (e) {
      return 'error: $e';
    }
  }
  
}