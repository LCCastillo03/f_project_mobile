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
      final isPast = event.isPast();
      final isSubscribed = eventController.events[index].subscribed;

      // Format time properly with leading zeros
      final formattedTime = DateFormat('HH:mm').format(event.date);
      final formattedMonth = DateFormat('MMM').format(event.date);
      final formattedDayOfWeek = DateFormat('EEEE').format(event.date);

      return GestureDetector(
        onTap: () => eventController.navigateTo(context, index),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(
                    94, 37, 154, 0.05), // Using RGBA instead of withOpacity
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Date container
                _buildDateContainer(formattedMonth, event.date.day.toString()),
                const SizedBox(width: 16),

                // Event details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Event title
                      Text(
                        clipText(event.name, 23),
                        style: const TextStyle(
                          color: AppColors.darkPurple,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Organizer
                      Text(
                        clipText('By ${event.author}', 26),
                        style: const TextStyle(
                          color: Color.fromRGBO(94, 37, 154,
                              0.8), // Using RGBA instead of withOpacity
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Date and time
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_rounded,
                            color: Color.fromRGBO(94, 37, 154,
                                0.7), // Using RGBA instead of withOpacity
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$formattedDayOfWeek - $formattedTime',
                            style: const TextStyle(
                              color: Color.fromRGBO(94, 37, 154,
                                  0.7), // Using RGBA instead of withOpacity
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action button
                _buildActionButton(isPast, isSubscribed, context, event),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildDateContainer(String month, String day) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF5E259A),
            Color(0xFF4E167A),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(
                78, 22, 122, 0.3), // Using RGBA instead of withOpacity
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            month,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            day,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      bool isPast, bool isSubscribed, BuildContext context, dynamic event) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          isPast
              ? fbController.navigateTo(context, event)
              : eventController.toggleSubscription(index);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              isPast
                  ? Icons.comment
                  : (isSubscribed
                      ? Icons.favorite
                      : Icons.favorite_border_rounded),
              color: isPast ? AppColors.darkPurple : Colors.red,
              size: 26,
              semanticLabel: isPast
                  ? 'Leave feedback'
                  : (isSubscribed
                      ? 'Remove from favorites'
                      : 'Add to favorites'),
            ),
          ),
        ),
      ),
    );
  }
}
