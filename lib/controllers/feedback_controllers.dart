import 'package:flutter/material.dart';
import 'package:project/data/repositories/feedback_repository.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/domain/models/feedback_model.dart';
import 'package:project/presentation/pages/feedback_create_page.dart';
import 'package:project/presentation/pages/feedback_page.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  RxList<FeedbackModel> feedbackList = <FeedbackModel>[].obs;

  @override
  void onInit() {
    feedbackList.assignAll(feedbackRepo); // TODO: connect to db
    super.onInit();
  }

  /*void addFeedback(FeedbackModel feedback) {
    feedbackList.add(feedback);
  }*/

  void toggleUpvote(int index) {
    final feedback = feedbackList[index];
    
    feedback.upvoted = !feedback.upvoted;
    feedback.votes += feedback.upvoted ? 1 : -1;

    if (feedback.upvoted && feedback.downvoted) {
      feedback.downvoted = false;
      feedback.votes++;
    }

    feedbackList.refresh();
  }

  void toggleDownvote(int index) {
    if (index >= 0 && index < feedbackList.length) {
      final feedback = feedbackList[index];

      feedback.downvoted = !feedback.downvoted;
      feedback.votes += feedback.downvoted ? -1 : 1;

      if (feedback.downvoted && feedback.upvoted) {
        feedback.upvoted = false;
        feedback.votes--;
      }

      feedbackList.refresh();
    }
  }

  void navigateTo(BuildContext context, EventModel event) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackPage(event: event)),
    );
  }

  void navigateToCreate(BuildContext context, String eventId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackCreatePage(eventId: eventId)),
    );
  }
  
}

// TODO: TAKE FROM EVENT CARD TO FEEDBACK CREATE