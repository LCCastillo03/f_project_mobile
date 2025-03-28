import 'package:flutter/material.dart';
import 'package:project/utils.dart';

class EventDetailsH extends StatelessWidget {
  final String eventName;
  final String author;
  final String month;
  final String day;
  final bool isfuture;

  const EventDetailsH({
    super.key,
    required this.eventName,
    required this.author,
    required this.month,
    required this.day,
    required this.isfuture,
  });

  @override
  Widget build(BuildContext context) {
    /* 
  TODO: 1 MAKE CLICKING ON WIDGET NAVIGATE TO EVENT DETAILS PAGE, AND ON ICON NAVIGATE TO FEEDBACK OR SUBSCRIBE 
  CONSIDER CHANGING TO STATEFUL WIDGET
  TODO: 2 REFLECT ON LOCAL STORAGE
  */
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Center(
            child: Text(
              clipText(eventName, 30),
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              clipText('by $author', 20),
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      month,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      day,
                      style: const TextStyle(
                        color: Color.fromARGB(207, 72, 64, 222),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (isfuture) ...[
                IconButton(
                  icon: const Icon(
                    Icons.access_time,
                    color: Color.fromARGB(207, 72, 64, 222),
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ] else ...[
                IconButton(
                  icon: const Icon(
                    Icons.comment,
                    color: Color.fromARGB(207, 72, 64, 222),
                    size: 20,
                  ),
                  onPressed: () {},
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
