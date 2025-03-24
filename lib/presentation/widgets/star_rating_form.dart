import 'package:flutter/material.dart';

class StarRatingForm extends StatelessWidget {
  final int selectedRating;
  final Function(int) onRatingSelected;

  const StarRatingForm({super.key, required this.selectedRating, required this.onRatingSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            Icons.star,
            color: Color(index < selectedRating ? 0XFF8A3D7A : 0xFF2e1c53),
            size: 60,
          ),
          onPressed: () => onRatingSelected(index + 1),
        );
      }),
    );
  }
}