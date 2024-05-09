import 'package:flutter/material.dart';
import 'package:attendance/Models/Question/Question.dart';
import 'package:attendance/Services/QuestionService.dart';
import 'package:attendance/Services/EpreuveService.dart';

class QuestionListView extends StatefulWidget {
  final int epreuveId; // Ajoutez cet attribut

  const QuestionListView({Key? key, required this.epreuveId}) : super(key: key);


  @override
  _QuestionListViewState createState() => _QuestionListViewState();
}

class _QuestionListViewState extends State<QuestionListView> {
  late Future<List<QuestionModel>> _questionsFuture;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      _questionsFuture = QuestionService().getQuestions();
    });
  }

  Future<void> _addQuestionToEpreuve(int questionId) async {
    // Afficher une boîte de dialogue pour confirmer l'ajout
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Voulez-vous ajouter cette question à l'épreuve ?"),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
                // Appeler la méthode pour ajouter la question à l'épreuve
                try {
                  await EpreuveService().addQuestionToEpreuve(widget.epreuveId, questionId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Question ajoutée à l\'épreuve avec succès')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erreur lors de l\'ajout de la question à l\'épreuve: $e')),
                  );
                }
              },
              child: const Text("Oui"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la boîte de dialogue
              },
              child: const Text("Non"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Questions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: const Color(0xFFFFAFAF),
        child: FutureBuilder<List<QuestionModel>>(
          future: _questionsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Une erreur s\'est produite: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<QuestionModel> questions = snapshot.data!;
              return ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  QuestionModel question = questions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    elevation: 4.0,
                    child: ListTile(
                      title: Text(
                        'Question... ${index + 1}: ${question.contenu}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        _addQuestionToEpreuve(question.id);
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Aucune question trouvée.'));
            }
          },
        ),
      ),
    );
  }
}
