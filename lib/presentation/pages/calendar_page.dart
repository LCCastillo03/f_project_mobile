import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/presentation/pages/event_detail_page.dart';
import 'package:project/presentation/theme/app_colors.dart';
import 'package:project/presentation/theme/categories.dart';
import 'package:project/presentation/widgets/event_details_h.dart'; //Widget de la lista de eventos
//se puede copiar y pegar el widget, ese nuevo widget se le cambia el estilo, y se cambia este import y fuera
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final EventsController eventsController = Get.find();
  late DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  String _selectedCategory = "All Events"; // Default filter

  List<EventModel> _getEventsForDay(DateTime day) {
    return eventsController.events.where((event) {
      final bool eventIsOnSelectedDay = isSameDay(event.date, day);
      final bool isCorrectCategory = _selectedCategory == "All Events" ||
          event.category == _selectedCategory;
      return eventIsOnSelectedDay && isCorrectCategory;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  void _showFilterDialog() {
    final categories = ["All Events", ...AppCategories.categories.keys];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.mediumPurple,
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return ListTile(
              title: Text(
                category,
                style: TextStyle(
                  color: _selectedCategory == category
                      ? AppColors.brightYellow
                      : Colors.white,
                  fontWeight: _selectedCategory == category
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final eventsForSelectedDay = _getEventsForDay(_selectedDay);
    final isPastDate = _selectedDay.isBefore(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
    );
    final sectionTitle = isPastDate
        ? 'Events on ${DateFormat.yMMMd().format(_selectedDay)}'
        : 'Upcoming Events';

    return Scaffold(
      backgroundColor: AppColors.darkPurple,
      appBar: AppBar(
        title: const Text(
          'Calendar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          _buildTableCalendar(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _showFilterDialog,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white30),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.filter_list,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 5),
                          Text(
                            'Filter: $_selectedCategory',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down,
                              color: Colors.white, size: 18),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                sectionTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: eventsForSelectedDay.isEmpty
                ? const Center(
                    child: Text(
                      'No events found for this day and filter.',
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    itemCount: eventsForSelectedDay.length,
                    itemBuilder: (context, index) {
                      final event = eventsForSelectedDay[index];
                      final originalIndex = eventsController.events
                          .indexWhere((e) => e.id == event.id);

                      if (originalIndex == -1) {
                        return const SizedBox.shrink();
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16.0),
                        decoration: BoxDecoration(
                          color: AppColors.mediumPurple,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(() => EventDetailPage(index: originalIndex));
                          },
                          child: EventDetailsH(index: originalIndex),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCalendar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppColors.mediumPurple,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16.0),
      child: TableCalendar<EventModel>(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        calendarFormat: _calendarFormat,
        eventLoader: _getEventsForDay,
        startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          // Match the design in the image
          todayDecoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            border: Border.all(color: Colors.white, width: 1),
            shape: BoxShape.circle,
          ),
          markerDecoration: const BoxDecoration(
            color: Colors.pink,
            shape: BoxShape.circle,
          ),
          markersMaxCount: 1,
          markerSize: 4,
          markerMargin: const EdgeInsets.only(top: 1),
          outsideDaysVisible: true,
          outsideTextStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
          defaultTextStyle: const TextStyle(color: Colors.white),
          weekendTextStyle: const TextStyle(color: Colors.white),
          selectedTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          todayTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          headerMargin: const EdgeInsets.only(bottom: 8.0),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          leftChevronIcon: Container(
            decoration: BoxDecoration(
              color: AppColors.darkPurple.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8.0),
            child:
                const Icon(Icons.chevron_left, color: Colors.white, size: 20),
          ),
          rightChevronIcon: Container(
            decoration: BoxDecoration(
              color: AppColors.darkPurple.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8.0),
            child:
                const Icon(Icons.chevron_right, color: Colors.white, size: 20),
          ),
        ),
        daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          weekendStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
        ),
        onDaySelected: _onDaySelected,
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
