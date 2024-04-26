import 'package:flutter/material.dart';

class SevenBlocksView extends StatelessWidget {
  const SevenBlocksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Ajouter l'image comme logo dans l'appBar
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/LOGO.png',
              width: 50,
              height: 50,
            ),
          ),
        ],
        title: const Text('DashBoat'),
        
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
                MaterialPageRoute(builder: (context) => ListeEtudiantsView()),
              );
            },
          ),
          BlockWidget(
            label: 'Enseignant',
            iconData: Icons.person,
            onTap: () {
              print('Enseignant clicked');
            },
          ),
          BlockWidget(
            label: 'Matieres',
            iconData: Icons.book,
            onTap: () {
              print('Matieres clicked');
            },
          ),
          BlockWidget(
            label: 'Épreuves',
            iconData: Icons.assignment,
            onTap: () {
              print('Épreuves clicked');
            },
          ),
          BlockWidget(
            label: 'Évaluations',
            iconData: Icons.rate_review,
            onTap: () {
              print('Évaluations clicked');
            },
          ),
          BlockWidget(
            label: 'Questions',
            iconData: Icons.question_answer,
            onTap: () {
              print('Questions clicked');
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
    Key? key,
    required this.label,
    required this.onTap,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        // Changer la couleur de l'ombre de la carte en orange
        shadowColor: Colors.orange,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 40,
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListeEtudiantsView extends StatelessWidget {
  const ListeEtudiantsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Étudiants'),
      ),
      body: Center(
        child: Text('Liste des étudiants ici'),
      ),
    );
  }
}
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SevenBlocksView(),
  ));
}
