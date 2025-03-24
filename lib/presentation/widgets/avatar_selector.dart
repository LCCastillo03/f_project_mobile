import 'package:flutter/material.dart';

class AvatarSelector extends StatelessWidget {
  final String selectedAvatar;

  const AvatarSelector({super.key, required this.selectedAvatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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
          tileMode: TileMode.mirror,
        ),
      ),
      child: Column(
        children: [
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
            runSpacing: 20,
            children: List.generate(5, (index) {
              return CircleAvatar(
                backgroundImage: AssetImage('images/stars.png'), // Replace as necessary
                radius: 30,
              );
            }),
          ),
        ],
      ),
    );
  }
}
