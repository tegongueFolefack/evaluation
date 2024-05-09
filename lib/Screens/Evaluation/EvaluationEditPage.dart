import 'package:flutter/material.dart';
import 'package:attendance/Models/Evaluation/Evaluation.dart';
import 'package:attendance/Services/EvaluationService.dart';
import 'package:fluttertoast/fluttertoast.dart';


class EvaluationEditPage extends StatefulWidget {
  final int EvaluationId;

  const EvaluationEditPage({super.key, required this.EvaluationId});

  @override
  _EvaluationEditPageState createState() => _EvaluationEditPageState();
}

class _EvaluationEditPageState extends State<EvaluationEditPage> {
  late Future<EvaluationModel> _EvaluationFuture;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _EvaluationFuture = EvaluationService().getEvaluationById(widget.EvaluationId);
    _noteController = TextEditingController();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modifier une Evaluation'),
      ),
      body: FutureBuilder<EvaluationModel>(
        future: _EvaluationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final Evaluation = snapshot.data!;
            _noteController.text = Evaluation.note.toString();
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _noteController,
                    decoration: const InputDecoration(labelText: 'Note'),
                  ),
                 
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Mettre à jour l'étudiant avec les nouvelles données
                      double noteValue = double.parse(_noteController.text);
                      final updatedEvaluation = EvaluationModel(
                        id: Evaluation.id,
                        note: noteValue,
                      );
                      EvaluationService().updateEvaluation(Evaluation.id, updatedEvaluation).then((_) {
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
