import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/presentation/pages/event_list_page.dart';

class FutureEventListPage extends StatelessWidget {
  final EventsController controller = Get.find();
  
  FutureEventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EventListPage(
      isPast: false,
      backgroundImage: "assets/images/background-blobs.png",
    );
  }
}