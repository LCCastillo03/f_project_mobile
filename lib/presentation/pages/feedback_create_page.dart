import 'package:flutter/material.dart';
import 'package:project/presentation/theme/app_colors.dart';
import 'package:project/presentation/widgets/avatar_selector.dart';
import 'package:project/presentation/widgets/comment_input.dart';
import 'package:project/presentation/widgets/star_rating_form.dart';
import 'package:project/utils.dart';

class FeedbackCreatePage extends StatefulWidget {
  final String eventId;

  const FeedbackCreatePage({super.key, required this.eventId});
  
  @override
  _FeedbackCreatePageState createState() => _FeedbackCreatePageState();
}

class _FeedbackCreatePageState extends State<FeedbackCreatePage> {
  int selectedRating = 0;
  TextEditingController commentController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  late String imagePath;

  // Function to handle rating selection
  void selectRating(int rating) => setState(() => selectedRating =  rating);

  // Function to handle avatar selection
  void changeAvatar(newImagePath) => setState(() => imagePath = newImagePath);

  @override
  void initState() {
    super.initState();
    imagePath = getAvatarPaths()[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows app bar to lay over body
      appBar: AppBar(
        forceMaterialTransparency: true,
        iconTheme: IconThemeData(
          size: 30,
          color: Colors.white,
        ),
        toolbarHeight: 58,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  decoration: BoxDecoration(
                    // Background image
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/stars.png'), 
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
                          backgroundColor: AppColors.brightYellow,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage(imagePath),
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
                                    color: AppColors.brightYellow,
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
                // Content under header
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 28, horizontal: 35),
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
                          selectedAvatar: imagePath),
                      SizedBox(height: 18),
                      // Comment sub-section
                      Text(
                        'Leave a comment',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      CommentInput(controller: commentController),
                      SizedBox(height: 25),
                      // Submit button
                      Center(
                        child: ElevatedButton(
                          // TODO: HANDLE FORM SUBMISSION (linked to eventId)
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.brightOrange,
                            padding: EdgeInsets.only(
                                top: 14, bottom: 14, left: 28, right: 18),
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
