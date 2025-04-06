import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/presentation/pages/event_list_page.dart';
import 'package:project/presentation/theme/app_colors.dart';

class PastFutureEventListPage extends StatelessWidget {
  final EventsController controller = Get.find();

  PastFutureEventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EventListPage(
      backgroundColor: AppColors.darkPurple,
    );
  }
}
