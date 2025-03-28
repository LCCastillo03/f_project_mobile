import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const SearchItem({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {  // TODO: .......
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFFFEF2EE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFFFBB385)),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}
