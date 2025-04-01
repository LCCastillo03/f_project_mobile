import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/presentation/pages/event_list_page.dart';


class PastEventListPage extends StatelessWidget {
  final EventsController controller = Get.find();
  
  PastEventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EventListPage(
      isPast: true,
      backgroundImage: "assets/images/olas-pasado.png",
    );
  }
}