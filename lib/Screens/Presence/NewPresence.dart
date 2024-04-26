import 'package:flutter/material.dart';

class NewPresence extends StatefulWidget {
  const NewPresence({super.key});

  @override
  State<NewPresence> createState() => _NewPresenceState();
}

class _NewPresenceState extends State<NewPresence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text("Bonjour presence"),
      ),
    );
  }
}
