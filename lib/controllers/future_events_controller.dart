import 'package:flutter/material.dart';
import 'package:project/data/repositories/events_repository.dart';

class FutureEventsController {
  late List eventList;
  late List<String> categories;
  final ValueNotifier<String?> selectedCategory = ValueNotifier<String?>(null);

  FutureEventsController() {
    _initializeData();
  }

  void _initializeData() {
    eventList = eventsRepo.where((event) => event.date.isAfter(DateTime.now())).toList();

    categories = eventList
        .map((e) => e.category as String)
        .toSet()
        .where((category) {
          final hasPastEvent = eventList.any((event) => event.category == category && event.date.isBefore(DateTime.now()));
          return !hasPastEvent;
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