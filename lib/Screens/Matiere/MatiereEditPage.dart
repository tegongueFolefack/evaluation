import 'package:flutter/material.dart';
import 'package:attendance/Models/Matiere/Matiere.dart';
import 'package:attendance/Services/MatiereService.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MatiereEditPage extends StatefulWidget {
  final int MatiereId;

  const MatiereEditPage({super.key, required this.MatiereId});

  @override
  _MatiereEditPageState createState() => _MatiereEditPageState();
}

class _MatiereEditPageState extends State<MatiereEditPage> {
  late Future<MatiereModel> _MatiereFuture;
  late TextEditingController _labelController;
  late TextEditingController _creditController;

  @override
  void initState() {
    super.initState();
    _MatiereFuture = MatiereService().getMatiereById(widget.MatiereId);
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
        title: const Text('Modifier une Matiere'),
      ),
      body: FutureBuilder<MatiereModel>(
        future: _MatiereFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final Matiere = snapshot.data!;
            _labelController.text = Matiere.label;
            _creditController.text = Matiere.credit.toString();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _labelController,
                    decoration: const InputDecoration(labelText: 'label'),
                  ),
                  TextFormField(
                    controller: _labelController,
                    decoration: const InputDecoration(labelText: 'credit'),
                  ),
                  
                  
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Mettre à jour l'étudiant avec les nouvelles données
                      int noteValue = int.parse(_creditController.text);
                      final updatedMatiere = MatiereModel(
                        id: Matiere.id,
                        label: _labelController.text,
                        credit: noteValue,
                      );
                      MatiereService().updateMatiere(Matiere.id, updatedMatiere).then((_) {
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
