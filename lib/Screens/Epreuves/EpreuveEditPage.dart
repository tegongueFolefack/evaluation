import 'package:flutter/material.dart';
import 'package:attendance/Models/Epreuve/Epreuve.dart';
import 'package:attendance/Services/EpreuveService.dart';
import 'package:fluttertoast/fluttertoast.dart';


class EpreuveEditPage extends StatefulWidget {
  final int EpreuveId;

  const EpreuveEditPage({super.key, required this.EpreuveId});

  @override
  _EpreuveEditPageState createState() => _EpreuveEditPageState();
}

class _EpreuveEditPageState extends State<EpreuveEditPage> {
  late Future<EpreuveModel> _EpreuveFuture;
  late TextEditingController _nomController;
  late TextEditingController _contenuController;

  @override
  void initState() {
    super.initState();
    _EpreuveFuture = EpreuveService().getEpreuveById(widget.EpreuveId);
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
        title: const Text('Modifier une epreuve'),
      ),
      body: FutureBuilder<EpreuveModel>(
        future: _EpreuveFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final Epreuve = snapshot.data!;
            _nomController.text = Epreuve.nom;
            _contenuController.text = Epreuve.contenu ?? '';
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
                    controller: _contenuController,
                    decoration: const InputDecoration(labelText: 'contenu'),
                  ),
                  
                  
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final updatedEpreuve = EpreuveModel(
                        id: Epreuve.id,
                        nom: _nomController.text,
                        contenu: _contenuController.text,
                      );
                      EpreuveService().updateEpreuve(Epreuve.id, updatedEpreuve).then((_) {
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
