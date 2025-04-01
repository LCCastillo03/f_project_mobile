import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/presentation/theme/app_colors.dart';
import 'package:project/utils.dart';
import '../widgets/search_item.dart';
import '../widgets/event_card.dart';
import 'package:project/controllers/events_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            spacing: 5,
            children: [
              const SizedBox(height: 40),
              // Greeting
              Text(
                greeting,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Search bar
              SearchItem(
                onChanged: (value) {}, // TODO: implement search
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
        ),
        // Home decoration
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
    // TODO: HOME SHOULD STORE SUBSCRIBED EVENTS
    final EventsController controller = Get.find();

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 380,
          child: Obx(() {
            return PageView.builder(
              controller: PageController(viewportFraction: 0.75),
              itemCount: controller.events.length,
              itemBuilder: (context, index) {
                return Center(
                  child: SizedBox(
                    width: constraints.maxWidth * 0.7,
                    child: EventCard(index: index),
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }
}
