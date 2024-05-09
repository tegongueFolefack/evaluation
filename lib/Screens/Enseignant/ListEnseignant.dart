import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance/Models/Enseignant/Enseignant.dart';
import 'package:attendance/Services/EnseignantService.dart';
import 'package:attendance/Screens/Enseignant/EnseignantRegistration.dart';
import 'package:attendance/Screens/Enseignant/EnseignantEditPage.dart';

class EnseignantListView extends StatefulWidget {
  const EnseignantListView({super.key});

  @override
  _EnseignantListViewState createState() => _EnseignantListViewState();
}

class _EnseignantListViewState extends State<EnseignantListView> {
  late Future<List<EnseignantModel>> _EnseignantsFuture;

  @override
  void initState() {
    super.initState();
    _loadEnseignants();
  }

  Future<void> _loadEnseignants() async {
    setState(() {
      _EnseignantsFuture = EnseignantService().getEnseignants();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Enseignants'),
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
        child: FutureBuilder<List<EnseignantModel>>(
          future: _EnseignantsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Une erreur s\'est produite: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<EnseignantModel> Enseignants = snapshot.data!;
              return ListView.builder(
                itemCount: Enseignants.length,
                itemBuilder: (context, index) {
                  EnseignantModel Enseignant = Enseignants[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    elevation: 4.0,
                    child: ListTile(
                      leading: const Icon(Icons.person), // Ajout de l'icône de la personne
                      title: Text(
                        Enseignant.nom,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Prénom: ${Enseignant.prenom}'),
                          Text('Email: ${Enseignant.email}'),
                          Text('Login: ${Enseignant.login}'),
                          Text('Téléphone: ${Enseignant.telephone}'),
                          Text('datePriseEns: ${Enseignant.datePriseEns}'),
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
                                  builder: (context) => EnseignantEditPage(EnseignantId: Enseignant.id),
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
                                    content: const Text("Êtes-vous sûr de vouloir supprimer cet énseignant ?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () async {
                                            Navigator.of(context).pop();
                                          try {
                                            await EnseignantService().deleteEnseignant(Enseignant.id);
                                            Fluttertoast.showToast(
                                              msg: "enseignant supprimé avec succès",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                            );
                                            _loadEnseignants();
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
              return const Center(child: Text('Aucun enseignant trouvé.'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EnseignantRegistrationPage()),
          );
          _loadEnseignants();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
