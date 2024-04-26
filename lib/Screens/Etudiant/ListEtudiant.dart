import 'package:flutter/material.dart';
import 'package:attendance/Models/Etudiant/Etudiant.dart';
import 'package:attendance/Services/EtudiantService.dart';

class EtudiantListView extends StatefulWidget {
  @override
  _EtudiantListViewState createState() => _EtudiantListViewState();
}

class _EtudiantListViewState extends State<EtudiantListView> {
  late Future<List<EtudiantModel>> _etudiantsFuture;

  @override
  void initState() {
    super.initState();
    _etudiantsFuture = EtudiantService().getEtudiants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Étudiants'),
      ),
      body: FutureBuilder<List<EtudiantModel>>(
        future: _etudiantsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Une erreur s\'est produite.'));
          } else if (snapshot.hasData) {
            List<EtudiantModel> etudiants = snapshot.data!;
            return 
            ListView.builder(
              itemCount: etudiants.length,
              itemBuilder: (context, index) {
                EtudiantModel etudiant = etudiants[index];
                return ListTile(
                  title: Text(etudiant.nom),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Prénom: ${etudiant.prenom}'),
                      Text('Password: ${etudiant.password}'),
                      Text('Login: ${etudiant.login}'),
                      Text('Téléphone: ${etudiant.telephone.toString()}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Action pour modifier l'étudiant
                          // Naviguer vers l'écran de modification ou afficher une boîte de dialogue, par exemple
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Action pour supprimer l'étudiant
                          // Afficher une boîte de dialogue de confirmation, par exemple
                        },
                      ),
                    ],
                  ),
                );
              },
            );

          } else {
            return Center(child: Text('Aucun étudiant trouvé.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action pour ajouter un nouvel étudiant
          // Naviguer vers l'écran d'ajout d'étudiant, par exemple
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
