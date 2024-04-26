import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:attendance/Screens/login/login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool _showText = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _showText = true;
      });
    });
    Timer(const Duration(seconds: 6), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const MyCustomLoginUI(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 236, 235),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Ajout du logo au milieu de la page
            Image.asset(
              'assets/images/LOGO.png', // Chemin vers votre image logo
              width: 200, // Ajustez la largeur selon vos besoins
              height: 200, // Ajustez la hauteur selon vos besoins
            ),
            AnimatedOpacity(
              opacity: _showText ? 1.0 : 0.0,
              duration: const Duration(seconds: 0),
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  FadeAnimatedText(
                    'ACADEMIE MANAGER',
                    duration: const Duration(seconds: 15),
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
