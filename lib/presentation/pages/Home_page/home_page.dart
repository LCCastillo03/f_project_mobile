import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 
import '../../widgets/search_item.dart' ;
import '../../widgets/event_card.dart'; 


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Live Event',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),

              _buildEventTarget(),
              
            ],
          ),
        ),
      ),
    );
  }

Widget _buildHeader() {
  String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now()); // Fecha actual

  return Stack(
    children: [
      Container(
        width: double.infinity,
        color: Color(0xFFFEF2EE),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20  ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 40),
            Text(
              'Schedule Event',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              formattedDate,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10), 
            SearchItem(
              onChanged: (value) {

              },
            ), 
          ],
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: SizedBox(
          height: 150,
          child: Image.asset(
            "assets/images/Deco_home.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
} 


Widget _buildEventTarget() {
  List<Map<String, String>> events = [
    {
      "imagePath": "assets/images/laterns-beach.png",
      "month": "Dec",
      "day": "24",
      "eventName": "Lantern Festival",
      "organizer": "Suku Zhong",
      "distance": "18.2",
      "location": "Angeles City",
    },
    {
      "imagePath":"assets/images/laterns-beach.png",
      "month": "Jan",
      "day": "01",
      "eventName": "New Year Fireworks",
      "organizer": "City Council",
      "distance": "10.5",
      "location": "New York",
    },
    {
      "imagePath": "assets/images/laterns-beach.png",
      "month": "Jul",
      "day": "15",
      "eventName": "Summer Music Fest",
      "organizer": "Live Nation",
      "distance": "25.8",
      "location": "Los Angeles",
    },
  ];

return LayoutBuilder(
  builder: (context, constraints) {
    bool isWeb = constraints.maxWidth > 600; 

    if (isWeb ) {
    
      return SizedBox(
        height: 800,
        child: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, 
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 0.8, 
          ),
          itemCount: events.length,
          itemBuilder: (context, index) {
            return EventCard(
              imagePath: events[index]["imagePath"]!,
              month: events[index]["month"]!,
              day: events[index]["day"]!,
              eventName: events[index]["eventName"]!,
              organizer: events[index]["organizer"]!,
              distance: events[index]["distance"]!,
              location: events[index]["location"]!,
            );
          },
        ),
      );
    } else {
   
      return SizedBox(
        height: 380,
        child: PageView.builder(
          controller: PageController(viewportFraction: 0.75),
          itemCount: events.length,
          itemBuilder: (context, index) {
            return Center(
              child: SizedBox(
                width: constraints.maxWidth * 0.7,
                child: EventCard(
                  imagePath: events[index]["imagePath"]!,
                  month: events[index]["month"]!,
                  day: events[index]["day"]!,
                  eventName: events[index]["eventName"]!,
                  organizer: events[index]["organizer"]!,
                  distance: events[index]["distance"]!,
                  location: events[index]["location"]!,
                ),
              ),
            );
          },
        ),
      );
    }
  },
);


}

}

