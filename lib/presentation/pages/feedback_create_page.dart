import 'package:flutter/material.dart';
import 'package:project/presentation/widgets/avatar_selector.dart';
import 'package:project/presentation/widgets/comment_input.dart';
import 'package:project/presentation/widgets/gradient_header.dart';
import 'package:project/presentation/widgets/star_rating_form.dart';

class FeedbackCreatePage extends StatefulWidget {
  @override
  _FeedbackCreatePageState createState() => _FeedbackCreatePageState();
}

class _FeedbackCreatePageState extends State<FeedbackCreatePage> {
  int selectedRating = 0;
  String image = "";
  TextEditingController commentController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  // Function to handle rating selection
  void selectRating(int rating) {
    setState(() {
      selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                GradientHeader(usernameController: usernameController),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'How was the conference?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      StarRatingForm(
                        selectedRating: selectedRating,
                        onRatingSelected: selectRating,
                      ),
                      SizedBox(height: 15),
                      AvatarSelector(selectedAvatar: image),
                      SizedBox(height: 25),
                      Text(
                        'Comment',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CommentInput(controller: commentController),
                      SizedBox(height: 38),
                      ElevatedButton(
                        onPressed: () {
                          print('Comment: ${commentController.text}');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0XFFF18262),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text(
                          'Submit feedback',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

}
