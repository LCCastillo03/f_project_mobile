import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/data/repositories/events_repository.dart';
import 'package:project/presentation/widgets/event_details_h.dart';
import '../widgets/search_item.dart';
import  '../../controllers/past_events_controller.dart';

class PastEventsPage extends StatefulWidget {
  const PastEventsPage({super.key});

  @override
  _PastEventsPageState createState()=> _PastEventsPageState();
}

class _PastEventsPageState extends State<PastEventsPage> {
  late PastEventsController controller;

  @override
  void initState() {
    super.initState();
    controller = PastEventsController();
  }
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
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 700,
          child: Image.asset(
            "assets/images/olas.png",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              SearchItem(
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              Center(
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    ValueListenableBuilder<String?>(
                      valueListenable: controller.selectedCategory,
                      builder: (context, selected, _) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                          onPressed: () {
                            controller.selectedCategory.value = null;
                          },
                          child: const Text("All"),
                        );
                      },
                    ),
                    ...controller.categories.map((category) {
                      return ValueListenableBuilder<String?>(
                        valueListenable: controller.selectedCategory,
                        builder: (context, selected, _) {
                          final isSelected = selected == category;
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              textStyle: const TextStyle(fontSize: 12),
                            ),
                            onPressed: () {
                              controller.selectedCategory.value = isSelected ? null : category;
                            },
                            child: Text(
                              category,
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ValueListenableBuilder<String?>(
                valueListenable: controller.selectedCategory,
                builder: (context, selected, _) {
                  final filteredEvents = controller.getFilteredEvents();

                  return Center(
                    child: SizedBox(
                      width: 175,
                      height: 500,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: filteredEvents.length,
                        itemBuilder: (context, index) {
                          final event = filteredEvents[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: EventDetailsH(
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
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
