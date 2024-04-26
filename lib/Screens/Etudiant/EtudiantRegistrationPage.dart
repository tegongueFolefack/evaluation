import 'package:flutter/material.dart';
import 'package:attendance/Models/Etudiant/Etudiant.dart';
import 'package:attendance/Services/EtudiantService.dart';

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
        title: const Text('Enregistrer un étudiant'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nomController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le nom de l\'étudiant';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(labelText: 'Prénom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le prénom de l\'étudiant';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir l\'email de l\'étudiant';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le mot de passe de l\'étudiant';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(labelText: 'Login'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le login de l\'étudiant';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telephoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Téléphone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le numéro de téléphone de l\'étudiant';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Si le formulaire est valide, on crée un nouvel étudiant
                      EtudiantModel newEtudiant = EtudiantModel(
                        nom: _nomController.text,
                        prenom: _prenomController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        login: _loginController.text,
                        telephone: int.parse(_telephoneController.text),
                      );

                      // Envoi de l'étudiant au service pour enregistrement
                      EtudiantService().saveEtudiant(newEtudiant).then((response) {
                        // Affichage d'un message de succès
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Étudiant enregistré avec succès')),
                        );
                        // Effacer les champs du formulaire
                        _nomController.clear();
                        _prenomController.clear();
                        _emailController.clear();
                        _passwordController.clear();
                        _loginController.clear();
                        _telephoneController.clear();
                      }).catchError((error) {
                        // En cas d'erreur, afficher un message d'erreur
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erreur: $error')),
                        );
                      });
                    }
                  },
                  child: const Text('Enregistrer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
