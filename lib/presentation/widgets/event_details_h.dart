import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/controllers/feedback_controllers.dart';
import 'package:project/presentation/theme/app_colors.dart';
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
            color: Colors.white70,
            borderRadius: BorderRadius.circular(16),
          ),
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Month and day
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 78, 22, 122),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      width: 75,
                      height: 75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(
                          DateFormat('MMMM').format(event.date),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.1,
                          ),
                        ),
                        Text(
                          event.date.day.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            height: 1.1,
                          ),
                        ),
                      ]),
                    ),
                    // Title and organizer
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          clipText(event.name, 23),
                          style: const TextStyle(
                            color: AppColors.darkPurple,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          clipText('By ${event.author}', 26),
                          style: TextStyle(
                            color: AppColors.darkPurple.withAlpha(200),
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // Day of week, time
                        Row(
                          spacing: 5,
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              color: AppColors.darkPurple.withAlpha(200),
                              size: 16,
                            ),
                            Text(
                              '${DateFormat('EEEE').format(event.date)} - ${event.date.hour}:${event.date.minute > 9 ? event.date.minute : '0${event.date.minute}'}',
                              style: TextStyle(
                                color: AppColors.darkPurple.withAlpha(200),
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                  // Icon at the end
                    IconButton(
                      icon: Icon(
                        event.isPast()
                            ? Icons.comment
                            : (eventController.events[index].subscribed
                                ? Icons.favorite
                                : Icons.favorite_border_rounded),
                        color: Color.fromARGB(255, 78, 22, 122),
                        size: 28,
                      ),
                      onPressed: () {
                        event.isPast()
                            ? fbController.navigateTo(context, event)
                            : eventController.toggleSubscription(index);
                      },
                    ),
            ],
          ),
        ),
      );
    });
  }
}
