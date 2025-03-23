import 'package:flutter/material.dart';
import 'package:project/presentation/pages/laterns.dart';
import 'package:project/presentation/pages/engine.dart';
import 'package:project/presentation/pages/education.dart';
import 'package:project/presentation/pages/business.dart';

class EventsController {
  static void navigateTo(BuildContext context, String event) {
    Widget page;
    switch (event) {
      case 'laterns':
        page = const LanternFestivalPage();
        break;
      case 'engine':
        page = const EnginePage();
        break;
      case 'education':
        page = const EducationPage();
        break;
      case 'business':
        page = const BusinessPage();
        break;
      default:
        return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
