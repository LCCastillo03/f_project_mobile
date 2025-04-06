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

  bool toggleSubscription(int index) {
    if (index >= 0 && index < events.length) {
      final EventModel currentEvent = events[index];

      // Si el usuario quiere suscribirse
      if (!currentEvent.subscribed) {
        // Verificamos si hay cupo disponible
        if (currentEvent.subscribedParticipants >=
            currentEvent.maxParticipants) {
          // No hay cupo disponible, mostramos mensaje y retornamos false
          Get.snackbar('No spaces available',
              'This event has reached its maximum capacity',
              backgroundColor: Colors.red,
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);
          return false;
        }

        // Hay cupo disponible, creamos un nuevo modelo con contador incrementado
        final EventModel updatedEvent = EventModel(
          id: currentEvent.id,
          name: currentEvent.name,
          author: currentEvent.author,
          category: currentEvent.category,
          description: currentEvent.description,
          location: currentEvent.location,
          date: currentEvent.date,
          subscribed: true, // Cambiamos a suscrito
          avgRating: currentEvent.avgRating,
          subscribedParticipants:
              currentEvent.subscribedParticipants + 1, // Incrementamos
          maxParticipants: currentEvent.maxParticipants,
          schedule: currentEvent.schedule, // Mantenemos el mismo schedule
        );

        // Reemplazamos el evento actual con el actualizado
        events[index] = updatedEvent;
      } else {
        // Si se está desuscribiendo, creamos nuevo modelo con contador decrementado
        final EventModel updatedEvent = EventModel(
          id: currentEvent.id,
          name: currentEvent.name,
          author: currentEvent.author,
          category: currentEvent.category,
          description: currentEvent.description,
          location: currentEvent.location,
          date: currentEvent.date,
          subscribed: false, // Cambiamos a no suscrito
          avgRating: currentEvent.avgRating,
          subscribedParticipants:
              currentEvent.subscribedParticipants - 1, // Decrementamos
          maxParticipants: currentEvent.maxParticipants,
          schedule: currentEvent.schedule, // Mantenemos el mismo schedule
        );

        // Reemplazamos el evento actual con el actualizado
        events[index] = updatedEvent;
      }

      events.refresh();
      return true;
    }
    return false;
  }

  List getTimeEvents(bool isPast) {
    return events
        .where((event) => (isPast ? event.isPast() : !event.isPast()))
        .toList();
  }

  List getFilteredEvents() {
    if (selectedCategory.value == "All") {
      return events
          .asMap()
          .entries
          .map((entry) => {
                "index": entry.key, // Original index before filtering
                "event": entry.value // Event object
              })
          .toList();
    }
    return events
        .asMap()
        .entries
        .where((entry) => entry.value.category == selectedCategory.value)
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
