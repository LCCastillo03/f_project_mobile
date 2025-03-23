import 'package:flutter/material.dart';

class EventDetailsH extends StatelessWidget {
  final String eventName;
  final String organizer;

  final String imagePath;
  final String month;
  final String day;
  final bool isfuture;

  const EventDetailsH({
    Key? key,
    required this.eventName,
    required this.organizer,

    required this.imagePath,
    required this.month,
    required this.day,
    required this.isfuture,
  }) : super(key: key);

  @override
Widget build(BuildContext context) {
  return Positioned(
    width: 100,
   
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              eventName,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              'by $organizer',
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      month,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      day,
                      style: const TextStyle(
                        color: Color.fromARGB(207, 72, 64, 222),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8), 
              if (isfuture) ...[
                 IconButton(
                    icon: const Icon(
                      Icons.access_time,
                      color: Color.fromARGB(207, 72, 64, 222),
                      size: 30,
                    ),
                    onPressed: () {
                    
                    },
                  ),
              ]else ...[
                IconButton(
                  icon: const Icon(
                    Icons.comment,
                    color: Color.fromARGB(207, 72, 64, 222),
                    size: 30,
                  ),
                  onPressed: () {
                    
                  },
                ),
              ],
             
            ],
          ),
        ],
      ),
    ),
  );
}

}
