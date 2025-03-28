import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:project/controllers/feedback_controllers.dart';
import 'package:project/domain/models/event_model.dart';
import 'package:project/utils.dart';
import '../widgets/agenda_item.dart';

class EventDetailPage extends StatefulWidget {
  final EventModel event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late String imagePath;
  bool subscribed = false;

  void handleSubscribe() {
    setState(() {
      // TODO: AFFECT LOCAL STORAGE
      subscribed = !subscribed;
    });
  }

  @override
  void initState() {
    super.initState();
    imagePath = widget.event.eventDecorationImagePath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows app bar to lay over body
      floatingActionButton: widget.event.isPast() ? _buildPastFooter() : _buildFutureFooter(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        forceMaterialTransparency: true,
        iconTheme: IconThemeData(
          size: 30,
          color: Colors.white,
        ),
        toolbarHeight: 58,
      ),
      backgroundColor: const Color(0xFF2e1c53),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildEventSchedule(),
                        const SizedBox(height: 30),
                        _buildEventDescription(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 90),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent, 
                Colors.transparent, 
                Color(0xFF2e1c53).withValues(alpha: 0.6), 
                Color(0xFF2e1c53), 
              ],
            ),
            //backgroundBlendMode: BlendMode.overlay,
          ),
        ),
        Column(
          spacing: 3,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              clipText(widget.event.name, 27),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              clipText('By ${widget.event.author}', 35),
              style: TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5,
              children: [
                Icon(
                  Icons.location_pin,
                  color: Colors.white54,
                  size: 16,
                ),
                Text(
                  clipText(widget.event.location, 40),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
            SizedBox(height: 23),
          ],
        ),
      ],
    );
  }

  Widget _buildEventSchedule() {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF443072),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Month, day
          Text(
            '${DateFormat('MMMM').format(widget.event.date)}\n${widget.event.date.day}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          // Weekday \ time
          Text(
            '${DateFormat('EEEE').format(widget.event.date)}\n${widget.event.date.hour}:${widget.event.date.minute > 9 ? widget.event.date.minute : '0${widget.event.date.minute}'}',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          // Calendar icon
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 8),
            child: SvgPicture.asset(
              "assets/icons/${subscribed ? 'calendar_joined' : 'calendar_empty'}.svg",
              width: 30.0,
              height: 30.0,
              colorFilter: const ColorFilter.mode(Color(0xFFf1c67a), BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }

  /*Widget _buildAgenda() { TODO: REVISE & DELETE
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Agenda',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              AgendaItem(
                  imagePath: "assets/images/business-icon.png",
                  title: 'FinTech Revolution',
                  date: 'June 12, 2025',
                  time: '10:00 pm'),
              SizedBox(width: 12),
              AgendaItem(
                  imagePath: "assets/images/science-icon.png",
                  title: 'Engineering Future',
                  date: 'June 16, 2025',
                  time: '9:00 pm'),
              SizedBox(width: 12),
              AgendaItem(
                  imagePath: "assets/images/education-icon.png",
                  title: 'Future of Learning',
                  date: 'June 16, 2025',
                  time: '7:00 pm'),
            ],
          ),
        ),
      ],
    );
  }*/

  Widget _buildEventDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        widget.event.description,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFutureFooter() {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 16),
        color: const Color.fromRGBO(46, 28, 83, 0.6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF443072), 
            borderRadius: BorderRadius.circular(12), 
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available spots',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${widget.event.subscribedParticipants}/${widget.event.maxParticipants}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFff5757),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => handleSubscribe(),
                child: Text(
                  subscribed ? 'Unsubscribe': 'Subscribe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPastFooter() {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 16),
        color: const Color.fromRGBO(46, 28, 83, 0.4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF443072), 
            borderRadius: BorderRadius.circular(12), 
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Average rating',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.event.avgRating.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Icon(
                          Icons.star,
                          color: Color(0xFFf1c67a),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFff5757),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => FeedbackController.navigateTo(context, widget.event),  // TODO: Redirect to feedback page
                child: Text(
                  'Reviews',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
