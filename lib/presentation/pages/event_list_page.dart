import 'package:flutter/material.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/presentation/theme/categories.dart';
import 'package:project/presentation/widgets/event_details_h.dart';
import '../widgets/search_item.dart';

class EventListPage extends StatefulWidget {
  final EventsController controller;
  final String backgroundImage;

  const EventListPage(
      {super.key, required this.controller, required this.backgroundImage});

  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(widget.backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 20,
                children: [
                  SizedBox(height: 10),
                  SearchItem(
                      onChanged: (value) {}), // TODO: search item action?
                  _buildCategoryList(),
                  _buildEventView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
            _buildButton(widget.controller.selectedCategory, "All"),
            ...AppCategories.categories.keys.toList().map((category) =>
                _buildButton(widget.controller.selectedCategory, category)),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(ValueNotifier<String?> selectedCategory, String category) {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedCategory,
      builder: (context, selected, _) {
        final isSelected = selected == category;
        return GestureDetector(
          onTap: () {
            selectedCategory.value =
                (!isSelected) & (category != "All") ? category : null;
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? Colors.white.withAlpha(240) : Colors.white54,
            ),
            padding: EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, spacing: 5, children: [
              category != "All"
                  ? Image.asset(AppCategories.categories[category]?["image"], width: 25, height: 25)
                  : Icon(Icons.category, size: 25),
              Text(
                category,
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
              ),
            ]),
          ),
        );
      },
    );
  }

  Widget _buildEventView() {
    return ValueListenableBuilder<String?>(
      valueListenable: widget.controller.selectedCategory,
      builder: (context, selected, _) {
        final filteredEvents = widget.controller.getFilteredEvents();
        return Wrap(
          spacing: 15,
          runSpacing: 15,
          alignment: WrapAlignment.center,
          children: filteredEvents.map((e) {
            return SizedBox(
              width: 160,
              height: 120,
              child: EventDetailsH(event: e),
            );
          }).toList(),
        );
      },
    );
  }
}
