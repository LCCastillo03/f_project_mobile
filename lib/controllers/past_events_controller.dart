import 'package:flutter/material.dart';
import 'package:project/data/repositories/events_repository.dart';

class PastEventsController {
  late List eventList;
  late List<String> categories;
  final ValueNotifier<String?> selectedCategory = ValueNotifier<String?>(null);

  PastEventsController() {
    _initializeData();
  }

  void _initializeData() {
    eventList = eventsRepo.where((event) => event.date.isBefore(DateTime.now())).toList();

    categories = eventList
        .map((e) => e.category as String)
        .toSet()
        .where((category) {
          final hasFutureEvent = eventList.any((event) => event.category == category && event.date.isAfter(DateTime.now()));
          return !hasFutureEvent;
        })
        .toList();
  }

  List getFilteredEvents() {
    if (selectedCategory.value == null) {
      return eventList;
    }
    return eventList.where((event) => event.category == selectedCategory.value).toList();
  }
}