import 'package:http/http.dart' as http;
import 'package:attendance/Models/AuthenticateRequest/User.dart';
import 'package:attendance/Services/server.dart';
import 'dart:convert';

// class UserService {
//   static Future<UserModel> authenticate(UserModel user) async {
//     try {
//       var url = Uri.parse(AppServer.LOGIN_USER);
      
//       final response = await http.post(
//         url,
//         headers: AppServer.headers,
//         body: jsonEncode(user.toJson()),
//       );

//       if (response.statusCode == 200) {
//         // Authentification réussie
//         print(response.body);
//         return UserModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
//       } else {       
//           throw Exception('Erreur d\'authentification: Réponse vide');
//         }
        
//     } catch (e) {
//       // Capturer et relancer l'exception
//       throw Exception('Erreur: $e');
//     }
//   }
// }

class UserService {
  static Future<UserModel> authenticate(UserModel user) async {
    try {
      var url = Uri.parse(AppServer.LOGIN_USER);
      
      final response = await http.post(
        url,
        headers: AppServer.headers,
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        // Authentification réussie
        print('Authentification réussie');
        print(response.body);
        // Vérifiez d'abord si la réponse n'est pas nulle
        if (response.body != null && response.body.isNotEmpty) {
          // Analysez la réponse JSON pour extraire les données nécessaires
          final responseData = jsonDecode(response.body) as Map<String, dynamic>;
          final userModel = UserModel.fromJson(responseData);
          return userModel;
        } else {
          throw Exception('Erreur d\'authentification: Réponse vide');
        }
      } else {
        // Si la réponse est nulle ou vide, lancez une exception
        throw Exception('Erreur d\'authentification: ${response.body}');
      }
    } catch (e) {
      // Capturer et relancer l'exception
      throw Exception('Erreur: $e');
    }
  }
}
