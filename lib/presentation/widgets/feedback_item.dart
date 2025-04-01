import 'package:flutter/material.dart';
import 'package:project/controllers/feedback_controllers.dart';
import 'package:project/domain/models/feedback_model.dart';
import 'package:project/presentation/theme/app_colors.dart';
import 'package:project/utils.dart';
import 'package:get/get.dart';

class FeedbackItem extends StatelessWidget {
  final int index;
  final FeedbackController controller = Get.find();

  FeedbackItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        final feedback = controller.feedbackList[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(feedback.profilePic),
                    radius: 25,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              clipText(feedback.username, 30),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              feedback.getTimestamp(),
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        _buildRatingStars(feedback.rating),
                        SizedBox(height: 8),
                        Text(
                          feedback.content,
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                feedback.upvoted
                                    ? Icons.thumb_up
                                    : Icons.thumb_up_off_alt,
                                color: feedback.upvoted
                                    ? AppColors.mediumPurple
                                    : Colors.grey,
                              ),
                              onPressed: () => controller.toggleUpvote(index),
                            ),
                            IconButton(
                              icon: Icon(
                                feedback.downvoted
                                    ? Icons.thumb_down
                                    : Icons.thumb_down_off_alt,
                                color: feedback.downvoted
                                    ? AppColors.mediumPurple
                                    : Colors.grey,
                              ),
                              onPressed: () => controller.toggleDownvote(index),
                            ),
                            SizedBox(width: 8),
                            Text(
                              '${feedback.votes} votes',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
            ],
          ),
        );
      });
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: AppColors.brightOrange,
          size: 16,
        ),
      ),
    );
  }
}