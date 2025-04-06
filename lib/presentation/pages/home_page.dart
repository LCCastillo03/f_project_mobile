import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/presentation/theme/app_colors.dart';
import 'package:project/utils.dart';
import '../widgets/search_item.dart';
import '../widgets/event_card.dart';
import 'package:project/controllers/events_controller.dart';
import '../widgets/event_schedule_widget.dart';
import 'package:project/domain/models/event_model.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final PageController _pageController = PageController(viewportFraction: 0.75);
  final RxInt currentPage = 0.obs;

  @override
  Widget build(BuildContext context) {
    final EventsController controller = Get.find();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final events = controller.events;

          return Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildEventTarget(context, events),
                      const SizedBox(height: 16),
                      // Cronograma del evento visible
                      if (events.isNotEmpty)
                        EventScheduleWidget(event: events[currentPage.value]),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeader() {
    String greeting = getGreeting();

    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: AppColors.sand,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                onChanged: (value) {}, // TODO: implement search
                backgroundColor: Colors.transparent,
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

  Widget _buildEventTarget(BuildContext context, List<EventModel> events) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 380,
          child: PageView.builder(
            controller: _pageController,
            itemCount: events.length,
            onPageChanged: (index) =>
                currentPage.value = index, // 👈 Actualiza página
            itemBuilder: (context, index) {
              return Center(
                child: SizedBox(
                  width: constraints.maxWidth * 0.7,
                  child: EventCard(index: index),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
