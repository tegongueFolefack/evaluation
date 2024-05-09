import 'package:http/http.dart' as http;
import 'package:attendance/Models/Authentication/AuthenticationRequest/AuthenticationRequest.dart';
import 'package:attendance/Services/server.dart';
import 'dart:convert';



class UserService {
  static Future<RequestModel> authenticate(String email, String password) async {
    try {
      var url = Uri.parse(AppServer.LOGIN_USER);
      final response = await http.post(
        url,
        headers: AppServer.headers,
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body) as Map<String, dynamic>;

        // Vérifier si les champs essentiels ne sont pas nulls
        if (responseData['email'] != null &&
            responseData['password'] != null &&
            responseData['roles'] != null &&
            responseData['access_token'] != null &&
            responseData['refresh_token'] != null &&
            responseData['token_type'] != null) {
          final user = RequestModel.fromJson(responseData);
          return user;
        } else {
          // Créer un message d'erreur spécifiant quel champ est null
          String nullField = '';
          if (responseData['email'] == null) nullField += 'email, ';
          if (responseData['password'] == null) nullField += 'password, ';
          if (responseData['roles'] == null) nullField += 'roles, ';
          if (responseData['access_token'] == null) nullField += 'access_token, ';
          if (responseData['refresh_token'] == null) nullField += 'refresh_token, ';
          if (responseData['token_type'] == null) nullField += 'token_type, ';
          throw Exception('Erreur d\'authentification: Les champs suivants sont nulls : $nullField');
        }
      } else {
        throw Exception('Erreur d\'authentification: ${response.body}');
      }
    } catch (e) {
      throw Exception('Erreur: $e');
    }
  }
}



