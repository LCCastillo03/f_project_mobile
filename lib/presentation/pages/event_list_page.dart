import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/presentation/theme/app_colors.dart';
import 'package:project/presentation/theme/categories.dart';
import 'package:project/presentation/widgets/event_details_h.dart';
import '../widgets/search_item.dart';

class EventListPage extends StatelessWidget {
  const EventListPage({super.key}); //

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
                  gradient: RadialGradient(colors: [
                    Color(0xff2b2771),
                    Color(0xff372173),
                    Color.fromARGB(255, 57, 29, 97),
                  ])
                ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(children: [
              // random stars
              ...List.generate(100, (index) {
                final random = Random();
                return Positioned(
                  left: random.nextDouble() * MediaQuery.of(context).size.width,
                  top: random.nextDouble() * MediaQuery.of(context).size.height,
                  child: Container(
                    width: random.nextDouble() * 3 +
                        1, // Random size for variation
                    height: random.nextDouble() * 3 + 1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Obx(() {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 20,
                    children: [
                      SearchItem(
                          onChanged: (value) {}), // TODO: search item action?
                      _buildCategoryList(),
                      _buildEventView(),
                      SizedBox(height: 20),
                    ],
                  );
                }),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

Widget _buildCategoryList() {
  return IntrinsicHeight(
    child: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 3),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: 7,
        children: [
          _buildButton("All"),
          ...AppCategories.categories.keys
              .toList()
              .map((category) => _buildButton(category)),
        ],
      ),
    ),
  );
}

Widget _buildButton(String category) {
  final EventsController controller = Get.find();
  return Obx(() {
    final isSelected = controller.selectedCategory.value == category;
    final Color categoryColor;
    if (category != "All" && AppCategories.categories[category] != null) {
      categoryColor =
          AppCategories.categories[category]["color"] ?? Colors.grey;
    } else {
      categoryColor = Color(0xFF443072);
    }
    return GestureDetector(
      onTap: () {
        controller.updateCategory(
            (!isSelected && category != "All") ? category : "All");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.white.withAlpha(240) : Colors.white54,
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          spacing: 5,
          children: [
            category != "All"
                ? Icon(
                    AppCategories.categories[category]?["icon"] ?? Icons.error,
                    size: 25,
                    color: categoryColor,
                  )
                : Icon(Icons.category, size: 25, color: categoryColor),
            Text(
              category,
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  });
}

Widget _buildEventView() {
  final EventsController controller = Get.find();

  final allEvents = controller.getFilteredEvents();
  final futureEvents = allEvents.where((e) => !e["event"].isPast()).toList();
  final pastEvents = allEvents.where((e) => e["event"].isPast()).toList();

  return Column(
    spacing: 25,
    children: [
      if (futureEvents.isNotEmpty) ...[
        _buildEventSublist("Future Events", futureEvents)
      ],
      if (pastEvents.isNotEmpty) ...[
        _buildEventSublist("Past Events", pastEvents)
      ],
      if (futureEvents.isEmpty && pastEvents.isEmpty) ...[
        SizedBox(height: 30),
        Text(
          'No events found for this category.',
          style: TextStyle(color: Colors.white54),
        ),
      ],
    ],
  );
}

Widget _buildEventSublist(title, List<dynamic> eventSublist) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 10,
    children: [
      Text(
        textAlign: TextAlign.start,
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Wrap(
        spacing: 15,
        runSpacing: 15,
        alignment: WrapAlignment.center,
        children: eventSublist.map((e) {
          return SizedBox(
            width: double.infinity,
            child: EventDetailsH(index: e["index"]),
          );
        }).toList(),
      ),
    ],
  );
}
