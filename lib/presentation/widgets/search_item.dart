import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchItem({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {  // TODO: .......
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
