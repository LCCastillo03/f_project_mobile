import 'package:flutter/material.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/domain/models/feedback_model.dart';
import 'package:project/presentation/pages/feedback_create_page.dart';
import 'package:project/presentation/pages/feedback_page.dart';

class FeedbackController {
  void toggleUpvote(FeedbackModel feedback) {
    // Handle upvote logic
  }

  void toggleDownvote(FeedbackModel feedback) {
    // Handle downvote logic
  }

  static void navigateTo(BuildContext context, EventModel event) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackPage(event: event)),
    );
  }

  static void navigateToCreate(BuildContext context, String eventId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackCreatePage(eventId: eventId)),
    );
  }
  
}

// TODO: TAKE FROM FEEDBACK LIST TO FEEDBACK CREATE
// TODO: TAKE FROM EVENT DETAIL PAGE TO FEEDBACK CREATE
// TODO: TAKE FROM EVENT CARD TO FEEDBACK CREATE