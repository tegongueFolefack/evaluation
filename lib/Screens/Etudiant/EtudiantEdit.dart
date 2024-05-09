import 'package:flutter/material.dart';
import 'package:attendance/Models/Etudiant/Etudiant.dart';
import 'package:attendance/Services/EtudiantService.dart';
import 'package:fluttertoast/fluttertoast.dart';


class EtudiantEditPage extends StatefulWidget {
  final int etudiantId;

  const EtudiantEditPage({super.key, required this.etudiantId});

  @override
  _EtudiantEditPageState createState() => _EtudiantEditPageState();
}

class _EtudiantEditPageState extends State<EtudiantEditPage> {
  late Future<EtudiantModel> _etudiantFuture;
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _loginController;
  late TextEditingController _telephoneController;

  @override
  void initState() {
    super.initState();
    _etudiantFuture = EtudiantService().getEtudiantById(widget.etudiantId);
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
        title: const Text('Modifier un étudiant'),
      ),
      body: FutureBuilder<EtudiantModel>(
        future: _etudiantFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final etudiant = snapshot.data!;
            _nomController.text = etudiant.nom;
            _prenomController.text = etudiant.prenom ?? '';
            _emailController.text = etudiant.email;
            _passwordController.text = etudiant.password ?? '';
            _loginController.text = etudiant.login;
            _telephoneController.text = etudiant.telephone.toString();
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
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Mettre à jour l'étudiant avec les nouvelles données
                      final updatedEtudiant = EtudiantModel(
                        id: etudiant.id,
                        nom: _nomController.text,
                        prenom: _prenomController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        login: _loginController.text,
                        telephone: int.parse(_telephoneController.text),
                      );
                      EtudiantService().updateEtudiant(etudiant.id, updatedEtudiant).then((_) {
                        // Afficher un toast pour confirmer que l'étudiant a été mis à jour avec succès
                        Fluttertoast.showToast(
                          msg: 'Étudiant mis à jour avec succès',
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
