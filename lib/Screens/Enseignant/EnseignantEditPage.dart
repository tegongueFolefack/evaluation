import 'package:flutter/material.dart';
import 'package:attendance/Models/Enseignant/Enseignant.dart';
import 'package:attendance/Services/EnseignantService.dart';
import 'package:fluttertoast/fluttertoast.dart';


class EnseignantEditPage extends StatefulWidget {
  final int EnseignantId;

  const EnseignantEditPage({super.key, required this.EnseignantId});

  @override
  _EnseignantEditPageState createState() => _EnseignantEditPageState();
}

class _EnseignantEditPageState extends State<EnseignantEditPage> {
  late Future<EnseignantModel> _EnseignantFuture;
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _loginController;
  late TextEditingController _telephoneController;
  late TextEditingController _datePriseEnsController;

  @override
  void initState() {
    super.initState();
    _EnseignantFuture = EnseignantService().getEnseignantById(widget.EnseignantId);
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
        title: const Text('Modifier un enseignant'),
      ),
      body: FutureBuilder<EnseignantModel>(
        future: _EnseignantFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final Enseignant = snapshot.data!;
            _nomController.text = Enseignant.nom;
            _prenomController.text = Enseignant.prenom ?? '';
            _emailController.text = Enseignant.email;
            _passwordController.text = Enseignant.password ?? '';
            _loginController.text = Enseignant.login;
            _telephoneController.text = Enseignant.telephone;
             _datePriseEnsController.text = Enseignant.datePriseEns;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _nomController,
                    decoration: const InputDecoration(labelText: 'Nom'),
                  ),
                  TextFormField(
                    controller: _prenomController,
                    decoration: const InputDecoration(labelText: 'Prénom'),
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Mot de passe'),
                  ),
                  TextFormField(
                    controller: _loginController,
                    decoration: const InputDecoration(labelText: 'Login'),
                  ),
                  TextFormField(
                    controller: _telephoneController,
                    decoration: const InputDecoration(labelText: 'Téléphone'),
                  ),
                  TextFormField(
                    controller: _datePriseEnsController,
                    decoration: const InputDecoration(labelText: 'datePriseEns'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Mettre à jour l'étudiant avec les nouvelles données
                      final updatedEnseignant = EnseignantModel(
                        id: Enseignant.id,
                        nom: _nomController.text,
                        prenom: _prenomController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        login: _loginController.text,
                        telephone: _telephoneController.text,
                        datePriseEns: Enseignant.datePriseEns,
                      );
                      EnseignantService().updateEnseignant(Enseignant.id, updatedEnseignant).then((_) {
                        // Afficher un toast pour confirmer que l'étudiant a été mis à jour avec succès
                        Fluttertoast.showToast(
                          msg: 'enseignant mis à jour avec succès',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                        );
                        
                        // Retourner à la page précédente avec un indicateur de succès
                        Navigator.pop(context, true);
                      }).catchError((error) {
                        // Gérer les erreurs ici
                      });
                    },
                    child: const Text('Enregistrer'),
                  ),

                ],
              ),
            );
          } else {
            return const Center(child: Text('Aucune donnée trouvée.'));
          }
        },
      ),
    );
  }
}
