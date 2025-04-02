import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/controllers/feedback_controllers.dart';
import 'package:project/utils.dart';

class EventDetailsH extends StatelessWidget {
  final int index;
  final EventsController eventController = Get.find();
  final FeedbackController fbController = Get.find();

  EventDetailsH({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final event = eventController.events[index];

      return GestureDetector(
        onTap: () => eventController.navigateTo(context, index),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 8, right: 8, top: 15, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15 , top: 4),
                  child: Column(children: [
                    
                    Text(
                      DateFormat('MMMM').format(event.date),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        height: 1,
                      ),
                    ),
                    Text(
                      event.date.day.toString(),
                      style: const TextStyle(
                        color: Color.fromARGB(207, 72, 64, 222),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(width: 10),
                Column(spacing: 5, children: [
                Text(
                  clipText(event.name, 15),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 0.95,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  clipText('By ${event.author}', 18),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]),
                IconButton(
                  icon: Icon(
                    event.isPast()
                        ? Icons.comment
                        : (eventController.events[index].subscribed
                            ? Icons.favorite
                            : Icons.favorite_border_rounded),
                    color: Color.fromARGB(207, 72, 64, 222),
                    size: 20,
                  ),
                  onPressed: () {
                    event.isPast()
                        ? fbController.navigateTo(context, event)
                        : eventController.toggleSubscription(index);
                  },
                ),
              ]),
            ],
          ),
        ),
      );
    });
  }
}
