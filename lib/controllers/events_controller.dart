import 'package:flutter/material.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/presentation/pages/event_detail_page.dart';

class EventsController {
  static void navigateTo(BuildContext context, EventModel event) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EventDetailPage(event: event)),
    );
  }
}
