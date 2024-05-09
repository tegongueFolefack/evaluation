import 'package:flutter/material.dart';
import 'package:attendance/Models/Question/Question.dart';
import 'package:attendance/Services/QuestionService.dart';
import 'package:fluttertoast/fluttertoast.dart';


class QuestionEditPage extends StatefulWidget {
  final int QuestionId;

  const QuestionEditPage({super.key, required this.QuestionId});

  @override
  _QuestionEditPageState createState() => _QuestionEditPageState();
}

class _QuestionEditPageState extends State<QuestionEditPage> {
  late Future<QuestionModel> _QuestionFuture;
  late TextEditingController _nomController;
  late TextEditingController _contenuController;

  @override
  void initState() {
    super.initState();
    _QuestionFuture = QuestionService().getQuestionById(widget.QuestionId);
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
        title: const Text('Modifier une Question'),
      ),
      body: FutureBuilder<QuestionModel>(
        future: _QuestionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final Question = snapshot.data!;
            _contenuController.text = Question.contenu ?? '';
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _contenuController,
                    decoration: const InputDecoration(labelText: 'contenu'),
                  ),
                  
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Mettre à jour l'étudiant avec les nouvelles données
                      final updatedQuestion = QuestionModel(
                        id: Question.id,
                        contenu: _contenuController.text,
                      );
                      QuestionService().updateQuestion(Question.id, updatedQuestion).then((_) {
                        // Afficher un toast pour confirmer que l'étudiant a été mis à jour avec succès
                        Fluttertoast.showToast(
                          msg: 'question mis à jour avec succès',
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
