import 'package:flutter/material.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/domain/models/event_model.dart';
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
                  SearchItem(onChanged: (value) {}),  // TODO: search item action?
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
    return SizedBox(
      height: 36,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 7,
          children: [
            ValueListenableBuilder<String?>(
              valueListenable: widget.controller.selectedCategory,
              builder: (context, selected, _) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  onPressed: () {
                    widget.controller.selectedCategory.value = null;
                  },
                  child: const Text("All"),
                );
              },
            ),
            ...EventModel.categories.map((category) =>
                _buildButton(widget.controller.selectedCategory, category)),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      ValueNotifier<String?> selectedCategory, String category) {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedCategory,
      builder: (context, selected, _) {
        final isSelected = selected == category;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            textStyle: const TextStyle(fontSize: 12),
          ),
          onPressed: () {
            selectedCategory.value = isSelected ? null : category;
          },
          child: Text(
            category,
            style: TextStyle(color: Colors.black87),
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
              width: 110,
              height: 125,
              child: EventDetailsH(event: e),
            );
          }).toList(),
        );
      },
    );
  }
}
