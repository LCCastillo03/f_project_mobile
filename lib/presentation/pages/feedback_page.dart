import 'package:flutter/material.dart';
import 'package:project/data/repositories/feedback_repository.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/domain/models/feedback_model.dart';
import 'package:project/presentation/widgets/feedback_item.dart';
import 'package:project/controllers/feedback_controllers.dart';

class FeedbackPage extends StatelessWidget {
  late List<FeedbackModel> feedbackList;
  final EventModel event;

  FeedbackPage({super.key, required this.event}) {
    feedbackList = feedbackRepo; // TODO: fetch feedback for eventId
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true, // Allows app bar to lay over body
        floatingActionButton: _buildAddButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        appBar: AppBar(
          forceMaterialTransparency: true,
          iconTheme: IconThemeData(
            size: 30,
            color: Colors.white,
          ),
          toolbarHeight: 58,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/blob-scene-purple.png",
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                  ),
                  Column(
                    children: [
                      _buildHeaderInfo(),
                      _buildFeedbackListView(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _buildAddButton(BuildContext context) {
    return GestureDetector(
      onTap: () => FeedbackController.navigateToCreate(context, event.id),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        padding: EdgeInsets.all(8),
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildHeaderInfo() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Text(
            'Feedback',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            event.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'By ${event.author}',
            style: const TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackListView(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: feedbackList.length,
        itemBuilder: (context, index) {
          return FeedbackItem(feedback: feedbackList[index]);
        },
      ),
    );
  }
}
