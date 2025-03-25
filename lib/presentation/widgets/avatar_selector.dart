
import 'package:flutter/material.dart';

class AvatarSelector extends StatelessWidget {
  final Function onAvatarSelected;
  final String selectedAvatar;

  const AvatarSelector({super.key, required this.onAvatarSelected, required this.selectedAvatar});

  @override
  Widget build(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 25),
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: Color(0xff3E2975),// Color(0xFF2E1C53), // Background color 
    ),
    child: Column(
      children: [
        Text(
          'Select avatar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        SizedBox(height: 15),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 20,
          runSpacing: 20,
          children: List.generate(5, (index) {
            return InkWell(
              borderRadius: BorderRadius.circular(80),
              hoverColor: Color.fromRGBO(108, 7, 121, 0.236),
              onTap: () => onAvatarSelected('avatar-$index.jpg'),
              child: CircleAvatar(
                backgroundColor: selectedAvatar == 'avatar-$index.jpg' ? Color(0xFFFFC765) : Colors.white,
                radius: 30,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatars/avatar-$index.jpg'), // Replace as necessary
                  radius: 28,
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
  }
  
}