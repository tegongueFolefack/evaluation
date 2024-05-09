import 'package:attendance/Screens/Matiere/ListMatiere.dart';
import 'package:attendance/Screens/Question/ListQuestion.dart';
import 'package:flutter/material.dart';
import 'package:attendance/Screens/Etudiant/ListEtudiant.dart';
import 'package:attendance/Screens/Enseignant/ListEnseignant.dart';
import 'package:attendance/Screens/Epreuves/ListEpreuve.dart';
import 'package:attendance/Screens/Evaluation/ListEvaluation.dart';


class SevenBlocksView extends StatelessWidget {
  const SevenBlocksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: const Color(0xFFF93F46), // Couleur de fond de la barre d'applications
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/LOGO.png', height: 30.0, width: 30.0),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          BlockWidget(
            label: 'Étudiant',
            iconData: Icons.school,
            onTap: () {
              // Naviguer vers la vue listant tous les étudiants
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EtudiantListView()),
              );
            },
          ),
          BlockWidget(
            label: 'Enseignant',
            iconData: Icons.person,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EnseignantListView()),
              );
            },
          ),
          BlockWidget(
            label: 'Matieres',
            iconData: Icons.book,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MatiereListView()),
              );
            },
          ),
          BlockWidget(
            label: 'Épreuves',
            iconData: Icons.assignment,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EpreuveListView()),
              );
            },
          ),
          BlockWidget(
            label: 'Évaluations',
            iconData: Icons.rate_review,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EvaluationListView()),
              );
            },
          ),
          BlockWidget(
            label: 'Questions',
            iconData: Icons.question_answer,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuestionListView()),
              );
            },
          ),
          // Add more BlockWidget instances as needed
        ],
      ),
    );
  }
}

class BlockWidget extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData iconData;

  const BlockWidget({
    super.key,
    required this.label,
    required this.onTap,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(16), // Augmenter la marge pour plus d'espace
        shadowColor: const Color.fromARGB(255, 13, 13, 13), // Changer la couleur de l'ombre
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 40,
                color: const Color(0xFFF93F46), // Changer la couleur de l'icône
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 13, 13, 13), // Changer la couleur du texte
                  fontFamily: 'Roboto', // Utiliser une police de caractères plus professionnelle
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SevenBlocksView(),
  ));
}
