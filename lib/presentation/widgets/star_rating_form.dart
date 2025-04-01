import 'package:flutter/material.dart';
import 'package:project/presentation/theme/app_colors.dart';

class StarRatingForm extends StatelessWidget {
  final int selectedRating;
  final Function(int) onRatingSelected;

  const StarRatingForm({super.key, required this.selectedRating, required this.onRatingSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        return GestureDetector(
          child: Icon(
            Icons.star,
            color: index < selectedRating ? AppColors.brightYellow : AppColors.brightYellow.withAlpha(157),
            size: 55,
          ),
          onTap: () => onRatingSelected(index + 1),
        );
      }),
    );
  }
}