import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance/Models/Evaluation/Evaluation.dart';
import 'package:attendance/Services/EvaluationService.dart';
import 'package:attendance/Screens/Evaluation/EvaluationEditPage.dart';
import 'package:attendance/Screens/Evaluation/EvaluationRegistration.dart';

class EvaluationListView extends StatefulWidget {
  const EvaluationListView({super.key});

  @override
  _EvaluationListViewState createState() => _EvaluationListViewState();
}

class _EvaluationListViewState extends State<EvaluationListView> {
  late Future<List<EvaluationModel>> _EvaluationsFuture;

  @override
  void initState() {
    super.initState();
    _loadEvaluations();
  }

  Future<void> _loadEvaluations() async {
    setState(() {
      _EvaluationsFuture = EvaluationService().getEvaluations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Évaluations'),
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
        child: FutureBuilder<List<EvaluationModel>>(
          future: _EvaluationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Une erreur s\'est produite: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<EvaluationModel> Evaluations = snapshot.data!;
              return ListView.builder(
                itemCount: Evaluations.length,
                itemBuilder: (context, index) {
                  EvaluationModel Evaluation = Evaluations[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    elevation: 4.0,
                    child: ListTile(
                      leading: const Icon(Icons.person), // Ajout de l'icône de la personne
                      title: Text(
                        'note: ${Evaluation.note.toString()}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
                                  builder: (context) => EvaluationEditPage(EvaluationId: Evaluation.id),
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
                                            await EvaluationService().deleteEvaluation(Evaluation.id);
                                            Fluttertoast.showToast(
                                              msg: "Étudiant supprimé avec succès",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                            );
                                            _loadEvaluations();
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
            MaterialPageRoute(builder: (context) => const EvaluationRegistrationPage()),
          );
          _loadEvaluations();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
