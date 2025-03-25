import 'package:flutter/material.dart';
import 'package:project/data/repositories/feedback_repository.dart';
import 'package:project/domain/models/feedback_model.dart';
import 'package:project/presentation/widgets/feedback_item.dart';
import 'package:project/presentation/widgets/floating_action_button.dart';

class FeedbackPage extends StatelessWidget {
  final List<FeedbackModel> feedbackList = feedbackRepo;

  FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 30),
                Column(
                  children: [
                    Padding(
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
                            'Engineering Future',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'By Elias Niño',
                            style: const TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: feedbackList.length,
                            itemBuilder: (context, index) {
                              return FeedbackItem(
                                  feedback: feedbackList[index]);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FloatingAddButton(onPressedAction: () {
            // TODO: TAKE TO WRITE FEEDBACK SCREEN
          }),
        ],
      )
    );
  }
}