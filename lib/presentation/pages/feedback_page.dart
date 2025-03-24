import 'package:flutter/material.dart';
import 'package:project/domain/models/feedback_model.dart';
import 'package:project/presentation/widgets/feedback_item.dart';
import 'package:project/presentation/widgets/floating_action_button.dart';

class FeedbackPage extends StatelessWidget {
  final List feedbackList = [
    {
      'username': 'Alice Johnson',
      'profilePic':
          'https://static.vecteezy.com/system/resources/previews/036/594/092/non_2x/man-empty-avatar-photo-placeholder-for-social-networks-resumes-forums-and-dating-sites-male-and-female-no-photo-images-for-unfilled-user-profile-free-vector.jpg',
      'timestamp': '2h ago',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis hendrerit sodales. Etiam malesuada, ex ac viverra volutpat, enim magna consectetur lacus, sed fringilla arcu nisi non ipsum. Nunc egestas, ligula ac auctor facilisis, lacus erat iaculis purus, at blandit nibh nunc sit amet nisl. Quisque eget turpis tincidunt, iaculis lorem in, blandit ligula. Duis interdum tempus est, sit amet dictum urna egestas nec. Pellentesque sit amet enim neque. Aenean porttitor enim quis tellus aliquam aliquam. Duis augue est, cursus ac lorem quis, blandit tincidunt lacus. Quisque varius metus quis nulla tincidunt, vel eleifend magna scelerisque. Ut eu sodales nulla. Aenean convallis dapibus metus a efficitur.',
      'rating': 5,
      'votes': 12,
    },
    {
      'username': 'Bob Smith',
      'profilePic':
          'https://static.vecteezy.com/system/resources/previews/036/594/092/non_2x/man-empty-avatar-photo-placeholder-for-social-networks-resumes-forums-and-dating-sites-male-and-female-no-photo-images-for-unfilled-user-profile-free-vector.jpg',
      'timestamp': '5h ago',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis hendrerit sodales.',
      'rating': 3,
      'votes': -2,
    },
    {
      'username': 'Charlie Lee',
      'profilePic':
          'https://static.vecteezy.com/system/resources/previews/036/594/092/non_2x/man-empty-avatar-photo-placeholder-for-social-networks-resumes-forums-and-dating-sites-male-and-female-no-photo-images-for-unfilled-user-profile-free-vector.jpg',
      'timestamp': '1d ago',
      'content':
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sagittis hendrerit sodales. Etiam malesuada, ex ac viverra volutpat, enim magna consectetur lacus, sed fringilla arcu nisi non ipsum. Nunc egestas, ligula ac auctor facilisis, lacus erat iaculis purus, at blandit nibh nunc sit amet nisl. Quisque eget turpis tincidunt, iaculis lorem in, blandit ligula. Duis interdum tempus est, sit amet dictum urna egestas nec. Pellentesque sit amet enim neque. Aenean porttitor enim quis tellus aliquam aliquam. Duis augue est, cursus ac lorem quis, blandit tincidunt lacus.',
      'rating': 4,
      'votes': 8,
    },
  ].map((item) {
    return FeedbackModel(
      username: item['username'] as String,
      profilePic: item['profilePic'] as String,
      timestamp: item['timestamp'] as String,
      content: item['content'] as String,
      rating: item['rating'] as int,
      votes: item['votes'] as int,
    );
  }).toList();

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