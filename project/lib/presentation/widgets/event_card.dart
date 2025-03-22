import 'package:flutter/material.dart';
import 'event_details.dart';

class EventCard extends StatelessWidget {
  final String imagePath;
  final String month;
  final String day;
  final String eventName;
  final String organizer;
  final String distance;
  final String location;

  const EventCard({
    Key? key,
    required this.imagePath,
    required this.month,
    required this.day,
    required this.eventName,
    required this.organizer,
    required this.distance,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 15,
              left: 15,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      month,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      day,
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
            EventDetails(
              eventName: eventName,
              organizer: organizer,
              distance: distance,
              location: location,
            ),
          ],
        ),
      ),
    );
  }
}
