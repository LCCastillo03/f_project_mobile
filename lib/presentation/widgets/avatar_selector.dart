import 'package:flutter/material.dart';
import 'package:project/utils.dart';

class AvatarSelector extends StatelessWidget {
  final Function onAvatarSelected;
  final String selectedAvatar;

  const AvatarSelector(
      {super.key,
      required this.onAvatarSelected,
      required this.selectedAvatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xFF2E1C53), // Background color
      ),
      child: Column(
        spacing: 15,
        children: [
          Text(
            'Select avatar',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 15,
            runSpacing: 15,
            children: getAvatarPaths().map((avatarPath) {
              return InkWell(
                borderRadius: BorderRadius.circular(80),
                hoverColor: Color.fromRGBO(108, 7, 121, 0.236),
                onTap: () => onAvatarSelected(avatarPath),
                child: CircleAvatar(
                  backgroundColor: selectedAvatar == avatarPath
                      ? Color(0xFFFFC765)
                      : Colors.white,
                  radius: 28,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(avatarPath),
                    radius: 25,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
