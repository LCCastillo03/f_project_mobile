import 'package:flutter/material.dart';

class AgendaItem extends StatelessWidget {
  final String title;
  final String time;
  final String date;
  final String imagePath;

  const AgendaItem({
    super.key,
    required this.title,
    required this.time,
    required this.date,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF443072),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: const TextStyle(
              color: Colors.white54,
//>>>>>>> main
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class AgendaList extends StatelessWidget {
  final List<AgendaItem> items;

  const AgendaList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500, // Altura suficiente para mostrar los eventos
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}