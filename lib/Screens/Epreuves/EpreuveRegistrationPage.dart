import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance/Models/Epreuve/Epreuve.dart';
import 'package:attendance/Services/EpreuveService.dart';
import 'package:attendance/Screens/Epreuves/ListEpreuve.dart';
import 'package:attendance/Screens/login/login.dart';

class EpreuveRegistrationPage extends StatefulWidget {
  const EpreuveRegistrationPage({super.key});

  @override
  _EpreuveRegistrationPageState createState() =>
      _EpreuveRegistrationPageState();
}

class _EpreuveRegistrationPageState extends State<EpreuveRegistrationPage> {
  late TextEditingController _nomController;
  late TextEditingController _contenuController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _nomController = TextEditingController();
    _contenuController = TextEditingController();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _contenuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ajaouter une epreuve'),
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
                  'Créer une epreuve',
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
                controller: _contenuController,
                decoration: const InputDecoration(
                  labelText: 'contenu',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le contenu de l\'étudiant';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
             
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Si le formulaire est valide, on vérifie également si les champs ne sont pas vides
                    if (_nomController.text.isEmpty ||
                        _contenuController.text.isEmpty ) {
                      Fluttertoast.showToast(
                        msg: 'Veuillez remplir tous les champs',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else {
                      // Si tous les champs sont remplis, on crée un nouvel étudiant
                      EpreuveModel newEpreuve = EpreuveModel(
                        nom: _nomController.text,
                        contenu: _contenuController.text,
                      );

                      // Envoi de l'étudiant au service pour enregistrement
                      EpreuveService()
                          .saveEpreuve(newEpreuve)
                          .then((response) {
                        // Effacer les champs du formulaire
                        _nomController.clear();
                        _contenuController.clear();

                        // Rediriger vers la page listant tous les étudiants
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EpreuveListView()),
                          (route) => false,
                        );
                      }).catchError((error) {
                        // En cas d'erreur, afficher un message d'erreur
                        Fluttertoast.showToast(
                          msg: 'epreuve enregistré avec succès',
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
