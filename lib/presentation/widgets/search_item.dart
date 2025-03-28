import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final Color backgroundColor;

  const SearchItem({super.key, required this.onChanged, this.backgroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {  // TODO: implement search
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          const Icon(Icons.search, color: Color(0xFFFBB385)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 11),
              child: TextField(
                onChanged: onChanged,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}
