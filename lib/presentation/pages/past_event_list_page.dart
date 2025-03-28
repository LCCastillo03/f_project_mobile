import 'package:flutter/material.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/data/repositories/events_repository.dart';
import 'package:project/presentation/pages/event_list_page.dart';

class PastEventListPage extends StatelessWidget {
  const PastEventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EventListPage(
      controller: EventsController(repository: PastEventRepository()),
      backgroundImage: "assets/images/olas-pasado.png",
    );
  }
}