import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/presentation/theme/categories.dart';
import 'package:project/presentation/widgets/event_details_h.dart';
import '../widgets/search_item.dart';

class EventListPage extends StatelessWidget {
  final String backgroundImage;
  final bool isPast;

  EventListPage(
      {super.key, required this.isPast, required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() { // try deleting
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 20,
                  children: [
                    SizedBox(height: 10),
                    SearchItem(
                        onChanged: (value) {}), // TODO: search item action?
                    _buildCategoryList(),
                    _buildEventView(isPast),
                  ],
                );
              }),
            ),
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

    return GestureDetector(
      onTap: () {
        controller.updateCategory(
            (!isSelected && category != "All") ? category : "All");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? Colors.white.withAlpha(240) : Colors.white54,
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            category != "All"
                ? Image.asset(AppCategories.categories[category]?["image"],
                    width: 25, height: 25)
                : Icon(Icons.category, size: 25),
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

Widget _buildEventView(bool fetchParam) {
  final EventsController controller = Get.find();
    final filteredEvents = controller.getFilteredEvents(fetchParam);
    return Wrap(
      spacing: 15,
      runSpacing: 15,
      alignment: WrapAlignment.center,
      children: filteredEvents.map((e) {
        return SizedBox(
          width: 160,
          height: 120,
          child: EventDetailsH(index: e["index"]),
        );
      }).toList(),
    );
}
