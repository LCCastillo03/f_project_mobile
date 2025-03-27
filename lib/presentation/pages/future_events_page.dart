import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/presentation/widgets/event_details_h.dart';
import '../widgets/search_item.dart';
import  '../../controllers/future_events_controller.dart';

class FutureEventsPage extends StatefulWidget {
  const FutureEventsPage({super.key});

  @override
  _FutureEventsPageState createState() => _FutureEventsPageState();
}

class _FutureEventsPageState extends State<FutureEventsPage> {
  late FutureEventsController controller;

  @override
  void initState() {
    super.initState();
    controller = FutureEventsController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 61, 44, 89),
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
            "assets/images/olasmoradas.png",
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