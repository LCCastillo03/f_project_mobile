import 'package:flutter/material.dart';

class CommentInput extends StatelessWidget {
  final TextEditingController controller;

  const CommentInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Write your thoughts here...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
