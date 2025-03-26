import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/data/repositories/events_repository.dart';

import 'package:project/presentation/widgets/event_details_h.dart';
import '../widgets/search_item.dart';

class PastEventsPage extends StatelessWidget {
  const PastEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFE9CD),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final List eventList = eventsRepo;

    return Stack(
      children: [
        Positioned(
          child: SizedBox(
            width: double.infinity,
            height: 700,
            child: Image.asset(
              "assets/images/olas.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 40),
              Center(
                child: Text(
                  'Past Events',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SearchItem(
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Center(
                    child: Text(
                      'Event History',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  height: 600,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: eventList.length,
                    itemBuilder: (context, index) {
                      final event = eventList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: EventDetailsH(
                          imagePath: event.eventDecorationImagePath(),
                          month: DateFormat('MMMM').format(event.date),
                          day: event.date.day.toString(),
                          eventName: event.name,
                          author: event.author,
                          isfuture: !event.isPast(),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
