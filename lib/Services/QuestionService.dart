
import 'package:attendance/Services/server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/Question/Question.dart';
class QuestionService{
  
  
  Future<QuestionModel> saveQuestion(QuestionModel e) async {
  try {
    var url = Uri.parse(AppServer.SAVE_QUESTION);
    Map<String, dynamic> requestBody = e.toJson();
    
    final response = await http.post(
      url,
      headers: AppServer.headers,
      body: jsonEncode(requestBody),
    );
    
    if (response.statusCode == 200) {
      print(response.body);
      return QuestionModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Échec de la création de l\'étudiant');
    }
  } catch (e) {
    throw Exception('$e');
  }
}

// Méthode pour récupérer un étudiant par son ID
  Future<QuestionModel> getQuestionById(int id) async {
    try {
      var url = Uri.parse("${AppServer.GET_ONE_QUESTION}$id");
      final response = await http.get(url, headers: AppServer.headers);
      if (response.statusCode == 200) {
        return QuestionModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Impossible de récupérer l\'étudiant');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  // Méthode pour mettre à jour un étudiant
  Future<void> updateQuestion(int id, QuestionModel Question) async {
    try {
      var url = Uri.parse("${AppServer.UPDATE_QUESTION}/$id");
      final response = await http.put(
        url,
        headers: AppServer.headers,
        body: jsonEncode(Question.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception('Échec de la mise à jour de l\'étudiant');
      }
    } catch (e) {
      throw Exception(' $e');
    }
  }

  // Méthode pour supprimer un étudiant
  Future<void> deleteQuestion(int id) async {
    try {
      var url = Uri.parse("${AppServer.DELETE_QUESTION}$id");
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

  Future<List<QuestionModel>> getQuestions() async {
  var url = Uri.parse(AppServer.GET_ALL);
  try {
    final response = await http.get(url, headers: AppServer.headers);
    if (response.statusCode == 200) {
      // Convertir le corps de la réponse en une liste JSON
      final List<dynamic> jsonData = json.decode(response.body);
      
      // Afficher les données JSON dans la console
      print(jsonData); 
      
      // Afficher le corps de la réponse dans la console
      print(response.body);
      
      // Créer une liste d'objets QuestionModel à partir des données JSON
      List<QuestionModel> Questions = jsonData.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>)).toList();
      
     
      
      // Retourner la liste des étudiants
      return Questions;
    } else {
      throw Exception('Échec de la récupération des étudiants: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception(' $e');
  }
}


  
}