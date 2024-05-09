import 'package:attendance/Screens/Epreuves/ListQuestionEpreuve.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance/Models/Epreuve/Epreuve.dart';
import 'package:attendance/Services/EpreuveService.dart';
import 'package:attendance/Screens/Epreuves/EpreuveEditPage.dart';
import 'package:attendance/Screens/Epreuves/EpreuveRegistrationPage.dart';

class EpreuveListView extends StatefulWidget {
  const EpreuveListView({super.key});

  @override
  _EpreuveListViewState createState() => _EpreuveListViewState();
}

class _EpreuveListViewState extends State<EpreuveListView> {
  late Future<List<EpreuveModel>> _EpreuvesFuture;

  @override
  void initState() {
    super.initState();
    _loadEpreuves();
  }

  Future<void> _loadEpreuves() async {
    setState(() {
      _EpreuvesFuture = EpreuveService().getEpreuves();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Epreuves'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: const Color(0xFFFFAFAF),
        child: FutureBuilder<List<EpreuveModel>>(
          future: _EpreuvesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Une erreur s\'est produite: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<EpreuveModel> Epreuves = snapshot.data!;
              return ListView.builder(
                itemCount: Epreuves.length,
                itemBuilder: (context, index) {
                  EpreuveModel Epreuve = Epreuves[index];
                  return GestureDetector(
                    onTap: () {
                      // Récupérer l'ID de l'épreuve et naviguer vers la vue des questions
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EpreuveQuestionListView(epreuveId: Epreuve.id),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      elevation: 4.0,
                      child: ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(
                          Epreuve.nom,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Epreuve...: ${Epreuve.contenu}'),
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
                                    builder: (context) => EpreuveEditPage(EpreuveId: Epreuve.id),
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
                                              await EpreuveService().deleteEpreuve(Epreuve.id);
                                              Fluttertoast.showToast(
                                                msg: "Étudiant supprimé avec succès",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor: Colors.green,
                                                textColor: Colors.white,
                                              );
                                              _loadEpreuves();
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
            MaterialPageRoute(builder: (context) => const EpreuveRegistrationPage()),
          );
          _loadEpreuves();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
