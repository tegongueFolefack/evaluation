import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance/Models/Matiere/Matiere.dart';
import 'package:attendance/Services/MatiereService.dart';
import 'package:attendance/Screens/Matiere/MatiereEditPage.dart';
import 'package:attendance/Screens/Matiere/MatiereRegistrationPage.dart';

class MatiereListView extends StatefulWidget {
  const MatiereListView({super.key});

  @override
  _MatiereListViewState createState() => _MatiereListViewState();
}

class _MatiereListViewState extends State<MatiereListView> {
  late Future<List<MatiereModel>> _MatieresFuture;

  @override
  void initState() {
    super.initState();
    _loadMatieres();
  }

  Future<void> _loadMatieres() async {
    setState(() {
      _MatieresFuture = MatiereService().getMatieres();
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
        child: FutureBuilder<List<MatiereModel>>(
          future: _MatieresFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Une erreur s\'est produite: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<MatiereModel> Matieres = snapshot.data!;
              return ListView.builder(
                itemCount: Matieres.length,
                itemBuilder: (context, index) {
                  MatiereModel Matiere = Matieres[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    elevation: 4.0,
                    child: ListTile(
                      leading: const Icon(Icons.person), // Ajout de l'icône de la personne
                      title: Text(
                        Matiere.label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('credit: ${Matiere.credit}'),
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
                                  builder: (context) => MatiereEditPage(MatiereId: Matiere.id),
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
                                            await MatiereService().deleteMatiere(Matiere.id);
                                            Fluttertoast.showToast(
                                              msg: "Étudiant supprimé avec succès",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                            );
                                            _loadMatieres();
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
            MaterialPageRoute(builder: (context) => const MatiereRegistrationPage()),
          );
          _loadMatieres();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
