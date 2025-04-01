import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/utils.dart';

class EventCard extends StatelessWidget {
  final int index;
  final EventsController controller = Get.find();

  EventCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final event = controller.events[index];
      return GestureDetector(
        onTap: () => controller.navigateTo(context, index),
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
                            onTap: () => controller.toggleSubscription(index),
                            child: Icon(
                              controller.events[index].subscribed
                                  ? Icons.favorite
                                  : Icons.favorite_border,
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
    });
  }
}
