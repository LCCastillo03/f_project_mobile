import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'presentation/pages/laterns.dart';
import 'presentation/pages/Home_page/home_page.dart';
import 'presentation/pages/Events_page/Past_events/past_events_page.dart';
import 'presentation/pages/Events_page/Future_events/future_events_page.dart';

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
      home: FutureEventsPage(),
      //home: PastEventsPage(),
      // home: LanternsPage(),
      // home: HomePage(),
    );
  }
}
