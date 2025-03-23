import 'package:flutter/material.dart';

class AgendaItem extends StatelessWidget {
  final String title;
/*<<<<<<< Rama_tubens
  final String subtitle;
  final String time;
//=======*/
  final String time;
  final String date;
//>>>>>>> main
  final String imagePath;

  const AgendaItem({
    super.key,
    required this.title,
/*<<<<<<< Rama_tubens
    required this.subtitle,
    required this.time,
//=======*/
    required this.time,
    required this.date,
//>>>>>>> main
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
/*<<<<<<< Rama_tubens
      width: 150,
      padding: const EdgeInsets.all(12),
=======*/
      width: 200,
      height: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(18),
// >>>>>>> main
      decoration: BoxDecoration(
        color: const Color(0xFF443072),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
/*<<<<<<< Rama_tubens
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath, // Ruta de la imagen
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
=======*/
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
//>>>>>>> main
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
/*<<<<<<< Rama_tubens
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
=======*/
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