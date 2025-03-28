import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/controllers/feedback_controllers.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/utils.dart';

class EventDetailsH extends StatelessWidget {
  final EventModel event;

  const EventDetailsH({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    /* 
  TODO: 1 MAKE CLICKING ON WIDGET NAVIGATE TO EVENT DETAILS PAGE, AND ON ICON NAVIGATE TO FEEDBACK OR SUBSCRIBE 
  CONSIDER CHANGING TO STATEFUL WIDGET
  TODO: 2 REFLECT ON LOCAL STORAGE
  */
    return GestureDetector(
      onTap: () => EventsNavController.navigateTo(context, event),
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
            Column(spacing: 5, children: [
              Text(
                clipText(event.name, 18),
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  height: 0.95,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                clipText('by ${event.author}', 20),
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(children: [
                  Text(
                    DateFormat('MMMM').format(event.date),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                      height: 1,
                    ),
                  ),
                  Text(
                    event.date.day.toString(),
                    style: const TextStyle(
                      color: Color.fromARGB(207, 72, 64, 222),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
              IconButton(
                icon: Icon(
                  event.isPast()
                      ? Icons.comment
                      : Icons.favorite_border_rounded,
                  color: Color.fromARGB(207, 72, 64, 222),
                  size: 20,
                ),
                onPressed: () {
                  event.isPast()
                      ? FeedbackController.navigateTo(context, event)
                      : {}; //TODO: toggle subscribe
                },
              ),
            ])
          ],
        ),
      ),
    );
  }
}
