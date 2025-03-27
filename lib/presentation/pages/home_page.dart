import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/data/repositories/events_repository.dart';
import 'package:project/domain/models/event_model.dart';
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
        backgroundColor: const Color.fromARGB(255, 250, 250, 250),
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
    
    final hour = DateTime.now().hour;

    String greeting;
    if (hour >= 5 && hour < 12) {
      greeting = 'Good Morning!';
    } else if (hour >= 12 && hour < 18) {
      greeting = 'Good Afternoon!';
    } else {
      greeting = 'Good Evening!';
    }
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
               Text(
                greeting,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SearchItem(
                onChanged: (value) {},
              ),
            ],
          ),
          
        ),
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
    List<EventModel> events = eventsRepo; // TODO: HOME SHOULD STORE SUBSCRIBED EVENTS

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
                  imagePath: events[index].eventDecorationImagePath(),
                  month: DateFormat('MMMM').format(events[index].date),
                  day: events[index].date.day.toString(),
                  eventName: events[index].name,
                  author: events[index].author,
                  distance: events[index].date.difference(DateTime.now()).inDays,
                  location: events[index].location,
                  onTap: () => EventsController.navigateTo(
                      context, events[index]),
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
                    child: EventCard( // TODO: FUTURE AND PAST EVENTS SHOULD HAVE DIFFERENT COLORS
                      imagePath: events[index].eventDecorationImagePath(),
                      month: DateFormat('MMMM').format(events[index].date),
                      day: events[index].date.day.toString(),
                      eventName: events[index].name,
                      author: events[index].author,
                      distance: events[index].date.difference(DateTime.now()).inDays,
                      location: events[index].location,
                      onTap: () => EventsController.navigateTo(
                          context, events[index]),
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
