import 'package:attendance/Screens/Welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Management',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffA9DED8),
        applyElevationOverlayColor: true,
        useMaterial3: true,
        fontFamily: "Arial, Sans Serif",
        cardColor: const Color(0xffA9DED8),
      ),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        applyElevationOverlayColor: true,
        useMaterial3: true,
        fontFamily: "Arial, Sans Serif",
        cardColor: Colors.white38,
        indicatorColor: Colors.purpleAccent,
        shadowColor: const Color(0xffA9DED8)
      ),
      home:  const WelcomePage()
    );
  }
}