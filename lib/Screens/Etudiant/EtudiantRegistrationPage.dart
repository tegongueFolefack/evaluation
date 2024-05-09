import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance/Models/Etudiant/Etudiant.dart';
import 'package:attendance/Services/EtudiantService.dart';
import 'package:attendance/Screens/Etudiant/ListEtudiant.dart';
import 'package:attendance/Screens/login/login.dart';

class EtudiantRegistrationPage extends StatefulWidget {
  const EtudiantRegistrationPage({super.key});

  @override
  _EtudiantRegistrationPageState createState() =>
      _EtudiantRegistrationPageState();
}

class _EtudiantRegistrationPageState extends State<EtudiantRegistrationPage> {
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _loginController;
  late TextEditingController _telephoneController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _nomController = TextEditingController();
    _prenomController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _loginController = TextEditingController();
    _telephoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _loginController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription'),
        backgroundColor: Colors.white, // Couleur de fond de la barre d'applications
        iconTheme: const IconThemeData(color: Colors.black), // Couleur de l'icône de retour
        elevation: 0, // Supprimer l'ombre de la barre d'applications
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                Icon(
                  Icons.person_add,
                  size: 40,
                ),
                SizedBox(height: 10),
                Text(
                  'Créer un compte',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le nom de l\'étudiant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(
                  labelText: 'Prénom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le prénom de l\'étudiant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir l\'email de l\'étudiant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le mot de passe de l\'étudiant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(
                  labelText: 'Login',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le login de l\'étudiant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _telephoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Téléphone',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le numéro de téléphone de l\'étudiant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Si le formulaire est valide, on vérifie également si les champs ne sont pas vides
                    if (_nomController.text.isEmpty ||
                        _prenomController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _loginController.text.isEmpty ||
                        _telephoneController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: 'Veuillez remplir tous les champs',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else {
                      // Si tous les champs sont remplis, on crée un nouvel étudiant
                      EtudiantModel newEtudiant = EtudiantModel(
                        nom: _nomController.text,
                        prenom: _prenomController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        login: _loginController.text,
                        telephone: int.parse(_telephoneController.text),
                      );

                      // Envoi de l'étudiant au service pour enregistrement
                      EtudiantService()
                          .saveEtudiant(newEtudiant)
                          .then((response) {
                        // Effacer les champs du formulaire
                        _nomController.clear();
                        _prenomController.clear();
                        _emailController.clear();
                        _passwordController.clear();
                        _loginController.clear();
                        _telephoneController.clear();

                        // Rediriger vers la page listant tous les étudiants
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EtudiantListView()),
                          (route) => false,
                        );
                      }).catchError((error) {
                        // En cas d'erreur, afficher un message d'erreur
                        Fluttertoast.showToast(
                          msg: 'Étudiant enregistré avec succès',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                      });
                    }
                  }
                },
                child: const Text('Enregistrer'),
                
              ),
               const SizedBox(height: 20),
              const Divider(), // Ajout d'une ligne de séparation
              const SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCustomLoginUI())); // Redirection vers la page de connexion
                  },
                  child: const Text(
                    'Déjà un compte ? Se connecter',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
