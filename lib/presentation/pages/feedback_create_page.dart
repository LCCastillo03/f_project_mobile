import 'package:flutter/material.dart';
import 'package:project/presentation/widgets/avatar_selector.dart';
import 'package:project/presentation/widgets/comment_input.dart';
import 'package:project/presentation/widgets/star_rating_form.dart';

class FeedbackCreatePage extends StatefulWidget {
  @override
  _FeedbackCreatePageState createState() => _FeedbackCreatePageState();
}

class _FeedbackCreatePageState extends State<FeedbackCreatePage> {
  int selectedRating = 0;
  String imageName = "avatar-0.jpg";
  TextEditingController commentController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  // Function to handle rating selection
  void selectRating(int rating) {
    setState(() {
      selectedRating = rating;
    });
  }

  // Function to handle avatar selection
  void changeAvatar(newImageName) {
    setState(() {
      imageName = newImageName;
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
                // Header
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/stars.png'), // Background image
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        // Avatar Selected
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Color(0xFFFFC765),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('images/avatars/$imageName'),
                            radius: 56,
                          ),
                        ),
                        SizedBox(height: 10),
                        // User Name Input
                        SizedBox(
                          width: 250,
                          child: TextField(
                            controller: usernameController,
                            maxLength: 20,
                            decoration: InputDecoration(
                              hintText: 'Enter your name',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .white), // Underline color when not focused
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFFFC765),
                                    width: 2), // Underline color when focused
                              ),
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            cursorColor: Colors.white,
                            buildCounter: (context,
                                {required int currentLength,
                                required bool isFocused,
                                required int? maxLength}) {
                              return Text(
                                '$currentLength / $maxLength',
                                style: TextStyle(
                                  color: currentLength > maxLength!
                                      ? Colors.red
                                      : Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // How was the conference sub-section
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
                      // Avatar Selector sub-section
                      AvatarSelector(
                          onAvatarSelected: changeAvatar,
                          selectedAvatar: imageName),
                      SizedBox(height: 23),
                      // Comment sub-section
                      Text(
                        'Comment',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CommentInput(controller: commentController),
                      SizedBox(height: 29),
                      // Submit button
                      Center(
                        child: ElevatedButton(
                          // TODO: HANDLE FORM SUBMISSION
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color(0XFFF18262),
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 30, right: 20),
                          ),
                          child: Row(
                            spacing: 15,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Send',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Transform.rotate(
                                angle: 3.14 / 5 * 9,
                                child: Icon(
                                  Icons.send_rounded,
                                  color: Colors.white,
                                ),
                              )
                            ],
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
