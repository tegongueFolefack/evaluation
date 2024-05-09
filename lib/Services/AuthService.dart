import 'package:attendance/Models/Authentication/AuthenticationRequest/AuthenticationRequest.dart';
import 'package:attendance/Models/Authentication/Response/AuthenticationResponse/AuthenticationResponse.dart';
import 'package:http/http.dart' as http;
import 'package:attendance/Services/server.dart';
import 'dart:convert';

class AuthService {
  static Future<AuthenticationResponseModel> authenticate(
      RequestModel request) async {
    try {
      var url = Uri.parse(AppServer.LOGIN_USER);
      final response = await http.post(
        url,
        headers: AppServer.headers,
        body: jsonEncode(request.toJson()),
      );

      if (response.statusCode == 200) {
        print(response.body);
        final responseData = jsonDecode(response.body);
        return AuthenticationResponseModel.fromJson(responseData);
      } else {
        //print(response.body);
        throw Exception('Erreur d\'authentification: ${response.body}');
        
      }
    } catch (e) {
      //  var url = Uri.parse(AppServer.LOGIN_USER);
      // final response = await http.post(
      //   url,
      //   headers: AppServer.headers,
      //   body: jsonEncode(request.toJson()),
      // );

      // if (response.statusCode == 200) {
      //   print(response.body);
      //   final responseData = jsonDecode(response.body);
      //   return AuthenticationResponseModel.fromJson(responseData);
      // } else {
      //   //print(response.body);
      //   throw Exception('Erreur d\'authentification: ${response.body}');
        
      // }
      throw Exception('Erreur: $e');
    }
  }
}
