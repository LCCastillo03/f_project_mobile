import 'package:flutter/material.dart';
import 'package:project/domain/models/feedback_model.dart';
import 'package:project/utils.dart';

class FeedbackItem extends StatefulWidget {
  final FeedbackModel feedback;

  const FeedbackItem({super.key, required this.feedback});

  @override
  _FeedbackItemState createState() => _FeedbackItemState();
}

class _FeedbackItemState extends State<FeedbackItem> {
  bool upvoted = false;
  bool downvoted = false;
  int votes = 0;

  @override
  void initState() {
    super.initState();
    votes = widget.feedback.votes;
  }

  void toggleUpvote() {
    setState(() {
      if (upvoted) {
        upvoted = false;
        votes--;
      } else {
        upvoted = true;
        votes++;
        if (downvoted) {
          downvoted = false;
          votes++;
        }
      }
    });
    // TODO: REFLECT ON LOCAL STORAGE
  }

  void toggleDownvote() {
    setState(() {
      if (downvoted) {
        downvoted = false;
        votes++;
      } else {
        downvoted = true;
        votes--;
        if (upvoted) {
          upvoted = false;
          votes--;
        }
      }
    });
    // TODO: REFLECT ON LOCAL STORAGE
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(widget.feedback.profilePic),
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
                          clipText(widget.feedback.username, 30),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.feedback.getTimestamp(),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    _buildRatingStars(widget.feedback.rating),
                    SizedBox(height: 8),
                    Text(
                      widget.feedback.content,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            upvoted
                                ? Icons.thumb_up
                                : Icons.thumb_up_off_alt,
                            color: upvoted
                                ? const Color(0xFF443072)
                                : Colors.grey,
                          ),
                          onPressed: toggleUpvote,
                        ),
                        IconButton(
                          icon: Icon(
                            downvoted
                                ? Icons.thumb_down
                                : Icons.thumb_down_off_alt,
                            color: downvoted
                                ? const Color(0xFF443072)
                                : Colors.grey,
                          ),
                          onPressed: toggleDownvote,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '$votes votes',
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
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Color(0XFFF18262),
          size: 16,
        ),
      ),
    );
  }
}