import 'package:flutter/material.dart';
import 'package:project/presentation/theme/app_colors.dart';

class AgendaItem extends StatelessWidget {
  final String title;
  final String time;
  final String description;

  const AgendaItem({
    super.key,
    required this.title,
    required this.time,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.mediumPurple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center( 
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              time,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
          ],
        ),
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