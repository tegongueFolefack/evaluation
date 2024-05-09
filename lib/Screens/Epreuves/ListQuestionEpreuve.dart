
import 'package:attendance/Screens/Epreuves/ListQuestion.dart';
import 'package:attendance/Services/EpreuveService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:attendance/Models/Question/Question.dart';
import 'package:attendance/Services/QuestionService.dart';
import 'package:attendance/Screens/Question/QuestionEditPage.dart';

class EpreuveQuestionListView extends StatefulWidget {
   final int epreuveId;

  const EpreuveQuestionListView({Key? key, required this.epreuveId}) : super(key: key);


  @override
  _EpreuveQuestionListViewState createState() => _EpreuveQuestionListViewState();
}

class _EpreuveQuestionListViewState extends State<EpreuveQuestionListView> {
  late Future<List<QuestionModel>> _questionsFuture;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() {
      _questionsFuture = EpreuveService().getQuestionsByEpreuveId(widget.epreuveId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions associées à l\'épreuve'),
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
                      leading: Checkbox(
                        value: question.isChecked,
                        onChanged: (value) {
                          setState(() {
                            question.isChecked = value ?? false;
                          });
                        },
                      ),
                      title: Text(
                        'Question ${question.id}: ${question.contenu}',
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
                                  builder: (context) => QuestionEditPage(QuestionId: question.id),
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
                                    content: const Text("Êtes-vous sûr de vouloir supprimer cette question ?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.of(context).pop();
                                          try {
                                            await QuestionService().deleteQuestion(question.id);
                                            Fluttertoast.showToast(
                                              msg: "Question supprimée avec succès",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.green,
                                              textColor: Colors.white,
                                            );
                                            _loadQuestions();
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
              return const Center(child: Text('Aucune question trouvée.'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  QuestionListView(epreuveId: widget.epreuveId)),
          );
          _loadQuestions();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
