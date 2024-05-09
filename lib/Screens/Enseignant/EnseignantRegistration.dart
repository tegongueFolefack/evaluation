import 'package:flutter/material.dart';
import 'package:attendance/Models/Enseignant/Enseignant.dart';
import 'package:attendance/Services/EnseignantService.dart';

class EnseignantRegistrationPage extends StatefulWidget {
  const EnseignantRegistrationPage({super.key});

  @override
  _EnseignantRegistrationPageState createState() =>
      _EnseignantRegistrationPageState();
}

class _EnseignantRegistrationPageState extends State<EnseignantRegistrationPage> {
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _loginController;
  late TextEditingController _telephoneController;
  late TextEditingController _datePriseEnsController;
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
     _datePriseEnsController = TextEditingController();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _loginController.dispose();
    _telephoneController.dispose();
    _datePriseEnsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enregistrer un Enseignant'),
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
                    return 'Veuillez saisir le nom de l\'Enseignant';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _prenomController,
                decoration: const InputDecoration(labelText: 'Prénom'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le prénom de l\'Enseignant';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir l\'email de l\'Enseignant';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Mot de passe'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le mot de passe de l\'Enseignant';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _loginController,
                decoration: const InputDecoration(labelText: 'Login'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le login de l\'Enseignant';
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
                    return 'Veuillez saisir le numéro de téléphone de l\'Enseignant';
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
                     // DateTime selectedDate = DateTime.parse(_datePriseEnsController.text);
                      EnseignantModel newEnseignant = EnseignantModel(
                        
                        nom: _nomController.text,
                        prenom: _prenomController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        login: _loginController.text,
                        telephone: _telephoneController.text,
                        datePriseEns: _datePriseEnsController.text,

                      );

                      // Envoi de l'étudiant au service pour enregistrement
                      EnseignantService().saveEnseignant(newEnseignant).then((response) {
                        // Affichage d'un message de succès
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enseignant enregistré avec succès')),
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
