import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance/Models/Etudiant/Etudiant.dart';
import 'package:attendance/Services/EtudiantService.dart';
import 'package:attendance/Screens/Etudiant/EtudiantRegistrationPage.dart';
import 'package:attendance/Screens/Etudiant/EtudiantEdit.dart';

class EtudiantListView extends StatefulWidget {
  const EtudiantListView({super.key});

  @override
  _EtudiantListViewState createState() => _EtudiantListViewState();
}

class _EtudiantListViewState extends State<EtudiantListView> {
  late Future<List<EtudiantModel>> _etudiantsFuture;

  @override
  void initState() {
    super.initState();
    _loadEtudiants();
  }

  Future<void> _loadEtudiants() async {
    setState(() {
      _etudiantsFuture = EtudiantService().getEtudiants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Étudiants'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Ajout de la fonction pour revenir à la page précédente
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/LOGO.png', height: 30.0, width: 30.0), // Ajout du logo dans le coin supérieur gauche
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFFFAFAF),  // Couleur orange pour le fond
        child: FutureBuilder<List<EtudiantModel>>(
          future: _etudiantsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Une erreur s\'est produite: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<EtudiantModel> etudiants = snapshot.data!;
              return ListView.builder(
                itemCount: etudiants.length,
                itemBuilder: (context, index) {
                  EtudiantModel etudiant = etudiants[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    elevation: 4.0,
                    child: ListTile(
                      leading: const Icon(Icons.person), // Ajout de l'icône de la personne
                      title: Text(
                        etudiant.nom,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Prénom: ${etudiant.prenom}'),
                          Text('Email: ${etudiant.email}'),
                          Text('Login: ${etudiant.login}'),
                          Text('Téléphone: ${etudiant.telephone}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EtudiantEditPage(etudiantId: etudiant.id),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirmation"),
                                    content: const Text("Êtes-vous sûr de vouloir supprimer cet étudiant ?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () async {
                                          
                                          Navigator.of(context).pop();
                                          try {
                                            await EtudiantService().deleteEtudiant(etudiant.id);
                                            Fluttertoast.showToast(
                                              msg: "Étudiant supprimé avec succès",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                            );
                                            _loadEtudiants();
                                          } catch (e) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Erreur lors de la suppression: $e')),
                                            );
                                          }
                                        },
                                        child: const Text("Oui"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Non"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Aucun étudiant trouvé.'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EtudiantRegistrationPage()),
          );
          _loadEtudiants();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
