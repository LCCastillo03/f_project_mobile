import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/data/repositories/events_repository.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/utils.dart';
import 'package:provider/provider.dart';
import '../widgets/search_item.dart';
import '../widgets/event_card.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/controllers/subscription_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SubscriptionController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
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
    String greeting = getGreeting();
    
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: const Color(0xFFFEF2EE),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              const SizedBox(height: 40),
              // Greeting
              Text(
                greeting,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Search bar
              SearchItem(
                onChanged: (value) {}, // TODO: implement search
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
        // Home decoration
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox(
            height: 150,
            child: Image.asset(
              "assets/images/Deco_home.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEventTarget(BuildContext context) {
    List<EventModel> events =
        eventsRepo; // TODO: HOME SHOULD STORE SUBSCRIBED EVENTS

    return LayoutBuilder(
      builder: (context, constraints) {
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
                    imagePath: events[index].eventDecorationImagePath(),
                    month: DateFormat('MMMM').format(events[index].date),
                    day: events[index].date.day.toString(),
                    eventName: events[index].name,
                    author: events[index].author,
                    date: events[index].date,
                    location: events[index].location,
                    onTap: () =>
                        EventsNavController.navigateTo(context, events[index]),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
