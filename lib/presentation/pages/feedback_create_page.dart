import 'package:flutter/material.dart';

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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                children: [
                  Container(
                    color: Color(0xFFFEF2EE),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          CircleAvatar(
                            backgroundImage: AssetImage('images/stars.png'),
                            radius: 60,
                          ),
                          SizedBox(height: 10),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: usernameController,
                              maxLength: 20,
                              decoration: InputDecoration(
                                hintText: 'Enter your name',
                              ),
                              textAlign: TextAlign.center,
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
                        Text( 
                          'How was the conference?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(5, (index) {
                            return IconButton(
                              icon: Icon(
                                Icons.star,
                                color: Color(index < selectedRating
                                    ? 0XFF8A3D7A
                                    : 0xFF2e1c53),
                                size: 60,
                              ),
                              onPressed: () => selectRating(index + 1),
                              onHover: (value) => {},
                            );
                          }),
                        ),
                        Divider(height: 20, color: Colors.grey[300]),
                        SizedBox(height: 10),
                        Text(
                          'Select avatar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          spacing: 20,
                          children: List.generate(5, (index) {
                            return CircleAvatar(
                              backgroundImage: AssetImage('images/stars.png'),
                              radius: 30,
                            );
                          }),
                        ),
                        SizedBox(height: 8),
                        Divider(height: 40, color: Colors.grey[300]),
                        Text(
                          'Comment',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: commentController,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'Write your thoughts here...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: SUMIT FEEDBACK ACTION
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
            ),
          );
        },
      ),
    );
  }
}
