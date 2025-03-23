import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/search_item.dart';
import '../../widgets/event_card.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/controllers/subscription_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SubscriptionController(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Live Event',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildEventTarget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: const Color(0xFFFEF2EE),
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Schedule Event',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              SearchItem(
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEventTarget(BuildContext context) {
    List<Map<String, String>> events = [
      {
        "imagePath": "assets/images/laterns-beach.png",
        "month": "Dec",
        "day": "24",
        "eventName": "Mindfulness Workshop",
        "organizer": "Marlon Piñeres",
        "distance": "18.2",
        "location": "Angeles City",
        "route": "laterns",
      },
      {
        "imagePath": "assets/images/stars.png",
        "month": "Jan",
        "day": "16",
        "eventName": "Engineering Future",
        "organizer": "Elias Niño",
        "distance": "10.5",
        "location": "New York",
        "route": "engine",
      },
      {
        "imagePath": "assets/images/atomic.png",
        "month": "Jun",
        "day": "16",
        "eventName": "Future of Learning",
        "organizer": "Miguel Jimeno",
        "distance": "25.8",
        "location": "Los Angeles",
        "route": "education",
      },
      {
        "imagePath": "assets/images/buildings.png",
        "month": "Jun",
        "day": "12",
        "eventName": "FinTech Revolution",
        "organizer": "Augusto Salazar",
        "distance": "30.2",
        "location": "San Francisco",
        "route": "business",
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWeb = constraints.maxWidth > 600;

        if (isWeb) {
          return SizedBox(
            height: 800,
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 0.8,
              ),
              itemCount: events.length,
              itemBuilder: (context, index) {
                return EventCard(
                  imagePath: events[index]["imagePath"]!,
                  month: events[index]["month"]!,
                  day: events[index]["day"]!,
                  eventName: events[index]["eventName"]!,
                  organizer: events[index]["organizer"]!,
                  distance: events[index]["distance"]!,
                  location: events[index]["location"]!,
                  onTap: () => EventsController.navigateTo(
                      context, events[index]["route"]!),
                );
              },
            ),
          );
        } else {
          return SizedBox(
            height: 380,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.75),
              itemCount: events.length,
              itemBuilder: (context, index) {
                return Center(
                  child: SizedBox(
                    width: constraints.maxWidth * 0.7,
                    child: EventCard(
                      imagePath: events[index]["imagePath"]!,
                      month: events[index]["month"]!,
                      day: events[index]["day"]!,
                      eventName: events[index]["eventName"]!,
                      organizer: events[index]["organizer"]!,
                      distance: events[index]["distance"]!,
                      location: events[index]["location"]!,
                      onTap: () => EventsController.navigateTo(
                          context, events[index]["route"]!),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
