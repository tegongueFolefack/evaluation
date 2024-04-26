import 'package:flutter/material.dart';

class ListEnseignant extends StatefulWidget {
  const ListEnseignant({super.key});

  @override
  State<ListEnseignant> createState() => _ListEnseignantState();
}

class _ListEnseignantState extends State<ListEnseignant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text("Bonjur enseignant"),
      ),
    );
  }
}
