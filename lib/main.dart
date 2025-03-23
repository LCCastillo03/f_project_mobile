import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'presentation/pages/laterns.dart';
//import 'presentation/pages/business.dart';
//import 'presentation/pages/engine.dart';
import 'presentation/pages/education.dart';

void main() {
  runApp(const LanternFestivalApp());
}

class LanternFestivalApp extends StatelessWidget {
  const LanternFestivalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: EducationPage(),
    );
  }
}
