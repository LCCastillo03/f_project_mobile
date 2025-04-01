import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/controllers/feedback_controllers.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/utils.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final int index;
  final EventsController evController = Get.find();
  final FeedbackController fbController = Get.find();

  EventCard({super.key, required this.event, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => evController.navigateTo(context, index),
      child: Container(
        width: 300,
        height: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(event.eventDecorationImagePath()),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: Stack(
          children: [
            // 📌 Fecha del evento
            Positioned(
              top: 15,
              left: 15,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      DateFormat('MMMM').format(event.date),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      event.date.day.toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(207, 72, 64, 222),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 📌 Detalles del evento con el corazón a la derecha del nombre
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 📌 Fila con el nombre del evento y el corazón
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            clipText(event.name, 20),
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            event.isPast()
                                ? fbController.navigateTo(context, event)
                                : evController.toggleSubscription(index);
                          },
                          child: Icon(
                            event.isPast() ? Icons.comment : Icons.favorite,
                            color: Colors.purple,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      clipText('By ${event.author}', 20),
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 3),
                    // 📌 Ubicación y distancia
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          clipText(event.location, 20),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          getTimestamp(event.date),
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
