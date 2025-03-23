import 'package:flutter/material.dart';

class EventCard extends StatefulWidget {
  final String imagePath;
  final String month;
  final String day;
  final String eventName;
  final String organizer;
  final String distance;
  final String location;
  final VoidCallback onTap;
  final bool isInitiallySubscribed;

  const EventCard({
    super.key,
    required this.imagePath,
    required this.month,
    required this.day,
    required this.eventName,
    required this.organizer,
    required this.distance,
    required this.location,
    required this.onTap,
    this.isInitiallySubscribed = false,
  });

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late bool isSubscribed;

  @override
  void initState() {
    super.initState();
    isSubscribed = widget.isInitiallySubscribed;
  }

  void toggleSubscription() {
    setState(() {
      isSubscribed = !isSubscribed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 300,
        height: 360,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(widget.imagePath),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: Stack(
          children: [
            // 📌 Fecha del evento
            Positioned(
              top: 15,
              left: 15,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      widget.month,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      widget.day,
                      style: const TextStyle(
                        color: Color.fromARGB(207, 72, 64, 222),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 📌 Detalles del evento con el corazón a la derecha del nombre
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 📌 Fila con el nombre del evento y el corazón
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.eventName,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: toggleSubscription,
                          child: Icon(
                            isSubscribed
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.purple, // Corazón morado
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'By ${widget.organizer}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // 📌 Ubicación y distancia
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.location,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '${widget.distance} km away',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
