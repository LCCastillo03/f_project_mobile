import 'package:flutter/material.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/domain/repositories/i_event_repository.dart';
import 'package:project/presentation/pages/event_detail_page.dart';

class EventsNavController {
  static void navigateTo(BuildContext context, EventModel event) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventDetailPage(event: event)),
    );
  }
}

class EventsController {
  final IEventRepository repository;
  final ValueNotifier<String?> selectedCategory = ValueNotifier<String?>(null);

  EventsController({required this.repository});

  List getFilteredEvents() {
    final eventList = repository.getEvents();
    if (selectedCategory.value == null) return eventList;
    return eventList.where((event) => event.category == selectedCategory.value).toList();
  }
}

// TODO: IMPLEMENT SUBSCRIBED EVENTS REPO?