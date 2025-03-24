import 'package:flutter/material.dart';
import 'package:project/domain/models/feedback_model.dart';

class FeedbackItem extends StatelessWidget {
  final FeedbackModel feedback;

  const FeedbackItem({super.key, required this.feedback});

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
                backgroundImage: NetworkImage(feedback.profilePic), 
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
                          feedback.username, 
                          style: TextStyle( 
                            fontSize: 14, 
                            fontWeight: FontWeight.bold, 
                          ), 
                        ), 
                        Text( 
                          feedback.timestamp, 
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
                          icon: Icon( // TODO: Apply GetX to dynamically change icon
                            Icons.thumb_up_off_alt,//upvoted ? Icons.thumb_up : Icons.thumb_up_off_alt, 
                            color: const Color(0xFF443072)//upvoted ? const Color(0xFF443072) : Colors.grey, 
                          ), 
                          onPressed: () => {}, 
                        ), 
                        IconButton( 
                          icon: Icon( // TODO: Apply GetX to dynamically change icon
                            Icons.thumb_down_off_alt,//downvoted ? Icons.thumb_down : Icons.thumb_down_off_alt, 
                            color: const Color(0xFF443072)//downvoted ? const Color(0xFF443072) : Colors.grey, 
                          ), 
                          onPressed: () => {}, 
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
/*
  @override
  void initState() {
    super.initState();
    votes = widget.feedback['votes'];
  }

  void _toggleUpvote() {  // TODO: REFLECT ON LOCAL STORAGE
    setState(() {
      if (upvoted) {
        upvoted = false;
        votes--;
      } else {
        upvoted = true;
        if (downvoted) {
          downvoted = false;
          votes++;
        }
        votes++;
      }
    });
  }

  void _toggleDownvote() {  // TODO: REFLECT ON LOCAL STORAGE
    setState(() {
      if (downvoted) {
        downvoted = false;
        votes++;
      } else {
        downvoted = true;
        if (upvoted) {
          upvoted = false;
          votes--;
        }
        votes--;
      }
    });
  }
*/