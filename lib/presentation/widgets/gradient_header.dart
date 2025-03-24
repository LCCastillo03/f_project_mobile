
import 'package:flutter/material.dart';

class GradientHeader extends StatelessWidget {
  final TextEditingController usernameController;

  const GradientHeader({super.key, required this.usernameController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color.fromRGBO(230, 193, 229, 0.4),
            Color.fromRGBO(223, 204, 231, 0.4),
            Color.fromRGBO(252, 239, 239, 0.4),
            Color.fromRGBO(244, 216, 195, 0.4),
            Color.fromRGBO(247, 204, 207, 0.4),
          ],
          tileMode: TileMode.decal,
        ),
      ),
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
    );
  }
}
