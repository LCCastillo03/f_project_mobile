import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project/data/repositories/events_repository.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/presentation/pages/event_detail_page.dart';

class EventsController extends GetxController {
  RxList<EventModel> events = <EventModel>[].obs;
  RxString selectedCategory = "All".obs;

  EventsController() {
    events.assignAll(eventsRepo);
  }

  void updateCategory(String newCategory) {
    selectedCategory.value = newCategory;
    events.refresh();
  }

  void toggleSubscription(int index) {
    if (index >= 0 && index < events.length) {
      events[index].subscribed = !events[index].subscribed;
    }
    events.refresh();
  }

  List getTimeEvents(bool isPast) {
    return events.where((event) => (isPast ? event.isPast() : !event.isPast())).toList();
  }

  List getFilteredEvents(bool isPast) {
    if (selectedCategory.value == "All") {
      return events
          .asMap()
          .entries
          .where((entry) => entry.value.isPast() == isPast)
          .map((entry) => {
                "index": entry.key, // Original index before filtering
                "event": entry.value // Event object
              })
          .toList();
    }
    return events
        .asMap()
        .entries
        .where((entry) => entry.value.category == selectedCategory.value && entry.value.isPast() == isPast)
        .map((entry) => {
              "index": entry.key, // Original index before filtering
              "event": entry.value // Event object
            })
        .toList();
  }

  void navigateTo(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventDetailPage(index: index)),
    );
  }
}
