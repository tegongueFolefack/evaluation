import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance/Models/Matiere/Matiere.dart';
import 'package:attendance/Services/MatiereService.dart';
import 'package:attendance/Screens/Matiere/ListMatiere.dart';
import 'package:attendance/Screens/login/login.dart';

class MatiereRegistrationPage extends StatefulWidget {
  const MatiereRegistrationPage({super.key});

  @override
  _MatiereRegistrationPageState createState() =>
      _MatiereRegistrationPageState();
}

class _MatiereRegistrationPageState extends State<MatiereRegistrationPage> {
  late TextEditingController _labelController;
  late TextEditingController _creditController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _labelController = TextEditingController();
    _creditController = TextEditingController();
  }

  @override
  void dispose() {
    _labelController.dispose();
    _creditController.dispose();
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
                  'Créer une Matiere',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _labelController,
                decoration: const InputDecoration(
                  labelText: 'label',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le label de matiere';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _creditController,
                decoration: const InputDecoration(
                  labelText: 'credit',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir le credit de la matiere';
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
                    if (_labelController.text.isEmpty ||
                        _creditController.text.isEmpty ) {
                      Fluttertoast.showToast(
                        msg: 'Veuillez remplir tous les champs',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else {
                      // Si tous les champs sont remplis, on crée un nouvel étudiant
                      int noteValue = int.parse(_creditController.text);
                      MatiereModel newMatiere = MatiereModel(
                        label: _labelController.text,
                        credit:noteValue,
                      );

                      // Envoi de l'étudiant au service pour enregistrement
                      MatiereService()
                          .saveMatiere(newMatiere)
                          .then((response) {
                        // Effacer les champs du formulaire
                        _labelController.clear();
                        _creditController.clear();

                        // Rediriger vers la page listant tous les étudiants
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MatiereListView()),
                          (route) => false,
                        );
                      }).catchError((error) {
                        // En cas d'erreur, afficher un message d'erreur
                        Fluttertoast.showToast(
                          msg: 'Matiere enregistré avec succès',
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
