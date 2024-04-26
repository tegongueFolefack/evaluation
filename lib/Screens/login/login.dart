import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:attendance/Screens/Etudiant/EtudiantRegistrationPage.dart';
import 'package:attendance/Screens/Enseignant/Enseignant.dart';
import 'package:attendance/services/UserService.dart'; // Importez votre service d'utilisateur
import 'package:attendance/Models/AuthenticateRequest/User.dart'; // Importez votre modèle UserModel
import 'package:attendance/Screens/Admin/liste.dart'; // Importez la page SevenBlocksView

class MyCustomLoginUI extends StatefulWidget {
  const MyCustomLoginUI({super.key});

  @override
  _MyCustomLoginUIState createState() => _MyCustomLoginUIState();
}

class _MyCustomLoginUIState extends State<MyCustomLoginUI> {
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  Future<void> _login() async {
    String email = _mailController.text;
    String password = _pwdController.text;

    // Créer un objet UserModel avec email et password
    var user = UserModel(email: email, password: password);
     Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SevenBlocksView()),
        );
    
   
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff292C31),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SE CONNECTER',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 230, 236, 235),
                ),
              ),
              SizedBox(height: height * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _mailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Email...',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Color.fromARGB(255, 230, 236, 235)),
                    ),
                    SizedBox(height: height * 0.02),
                    TextFormField(
                      controller: _pwdController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline),
                        hintText: 'Mot de passe...',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      obscureText: true,
                      style: const TextStyle(color: Color.fromARGB(255, 230, 236, 235)),
                    ),
                    SizedBox(height: height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            // Actions pour la récupération du mot de passe oublié
                          },
                          child: const Text(
                            'Mot de passe oublié',
                            style: TextStyle(color: Color.fromARGB(255, 230, 236, 235)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(0, height * 0.02, 0, 0),
                              items: [
                                PopupMenuItem(
                                  value: 'etudiant',
                                  child: const Text('Étudiant'),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EtudiantRegistrationPage()));
                                  },
                                ),
                                PopupMenuItem(
                                  value: 'enseignant',
                                  child: const Text('Enseignant'),
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EnseignantRegistrationPage()));
                                  },
                                ),
                              ],
                            );
                          },
                          child: const Text(
                            'Créer mon compte',
                            style: TextStyle(color: Color.fromARGB(255, 230, 236, 235)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.05),
                    ElevatedButton(
                      onPressed: _login, // Appeler la méthode _login lors du clic sur le bouton
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith<Color>(
                          (states) {
                            if (states.contains(WidgetState.disabled)) {
                              return Colors.grey; // Couleur lorsque le bouton est désactivé
                            }
                            return const Color.fromARGB(255, 230, 236, 235); // Couleur de fond du bouton
                          },
                        ),
                      ),
                      child: const Text(
                        'SE CONNECTER',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
