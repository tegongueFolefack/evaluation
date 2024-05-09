
import 'package:attendance/Services/server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/Evaluation/Evaluation.dart';
class EvaluationService{
  
  
  Future<EvaluationModel> saveEvaluation(EvaluationModel e) async {
  try {
    var url = Uri.parse(AppServer.SAVE_EVALUATION);
    Map<String, dynamic> requestBody = e.toJson();
    
    final response = await http.post(
      url,
      headers: AppServer.headers,
      body: jsonEncode(requestBody),
    );
    
    if (response.statusCode == 200) {
      print(response.body);
      return EvaluationModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Échec de la création de l\'étudiant');
    }
  } catch (e) {
    throw Exception('$e');
  }
}

// Méthode pour récupérer un étudiant par son ID
  Future<EvaluationModel> getEvaluationById(int id) async {
    try {
      var url = Uri.parse("${AppServer.GET_ONE_EVALUATION}$id");
      final response = await http.get(url, headers: AppServer.headers);
      if (response.statusCode == 200) {
        return EvaluationModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Impossible de récupérer l\'étudiant');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  // Méthode pour mettre à jour un étudiant
  Future<void> updateEvaluation(int id, EvaluationModel Evaluation) async {
    try {
      var url = Uri.parse("${AppServer.UPDATE_EVALUATION}/$id");
      final response = await http.put(
        url,
        headers: AppServer.headers,
        body: jsonEncode(Evaluation.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Échec de la mise à jour de l\'étudiant');
      }
    } catch (e) {
      throw Exception(' $e');
    }
  }

  // Méthode pour supprimer un étudiant
  Future<void> deleteEvaluation(int id) async {
    try {
      var url = Uri.parse("${AppServer.DELETE_EVALUATION}$id");
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

  Future<List<EvaluationModel>> getEvaluations() async {
  var url = Uri.parse(AppServer.LIST_EVALUATION);
  try {
    final response = await http.get(url, headers: AppServer.headers);
    if (response.statusCode == 200) {
      // Convertir le corps de la réponse en une liste JSON
      final List<dynamic> jsonData = json.decode(response.body);
      
      // Afficher les données JSON dans la console
      print(jsonData); 
      
      // Afficher le corps de la réponse dans la console
      print(response.body);
      
      // Créer une liste d'objets EvaluationModel à partir des données JSON
      List<EvaluationModel> Evaluations = jsonData.map((e) => EvaluationModel.fromJson(e as Map<String, dynamic>)).toList();
      
     
      
      // Retourner la liste des étudiants
      return Evaluations;
    } else {
      throw Exception('Échec de la récupération des étudiants: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception(' $e');
  }
}


  
}