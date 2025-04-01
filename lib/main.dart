import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/controllers/feedback_controllers.dart';
import 'package:project/controllers/navigation_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FeedbackController());
    Get.put(EventsController());
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavigationController(),
    );
  }
}