import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/controllers/events_controller.dart';
import 'package:project/controllers/feedback_controllers.dart';
import 'package:project/presentation/theme/app_colors.dart';
import 'package:project/utils.dart';

class EventDetailPage extends StatelessWidget {
  final int index;

  EventDetailPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    EventsController evController = Get.find();
    return Obx(() {
      final event = evController.events[index];
      return Scaffold(
        extendBodyBehindAppBar: true, // Allows app bar to lay over body
        floatingActionButton: event.isPast()
            ? _buildPastFooter(context, event)
            : _buildFutureFooter(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          forceMaterialTransparency: true,
          iconTheme: IconThemeData(
            size: 30,
            color: Colors.white,
          ),
          toolbarHeight: 58,
        ),
        backgroundColor: AppColors.darkPurple,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(
                    imagePath: event.eventDecorationImagePath(),
                    name: event.name,
                    author: event.author,
                    location: event.location,
                  ),
                  Center(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildEventSchedule(
                              date: event.date, isSubscribed: event.subscribed),
                          const SizedBox(height: 30),
                          _buildEventDescription(event.description),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 95),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHeader({imagePath, name, author, location}) {
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
                AppColors.darkPurple.withValues(alpha: 0.6),
                AppColors.darkPurple,
              ],
            ),
          ),
        ),
        Column(
          spacing: 3,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              clipText(name, 27),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              clipText('By $author', 35),
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
                  clipText(location, 40),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white54,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEventSchedule({date, isSubscribed}) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.mediumPurple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Month, day
          Text(
            '${DateFormat('MMMM').format(date)}\n${date.day}',
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
            '${DateFormat('EEEE').format(date)}\n${date.hour}:${date.minute > 9 ? date.minute : '0${date.minute}'}',
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
              "assets/icons/${isSubscribed ? 'calendar_joined' : 'calendar_empty'}.svg",
              width: 30.0,
              height: 30.0,
              colorFilter:
                  const ColorFilter.mode(AppColors.dimYellow, BlendMode.srcIn),
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

  Widget _buildEventDescription(description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        description,
        textAlign: TextAlign.justify,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFutureFooter() {
    EventsController evController = Get.find();
    return Obx(() {
      final event = evController.events[index];
      final bool isFull = event.subscribedParticipants >= event.maxParticipants;
      final bool canSubscribe = !isFull || event.subscribed;

      return IntrinsicHeight(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 16),
          color: const Color.fromRGBO(46, 28, 83, 0.6),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.mediumPurple,
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
                      '${event.subscribedParticipants}/${event.maxParticipants}',
                      style: TextStyle(
                        color: isFull ? Colors.red : Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isFull && !event.subscribed)
                      Text(
                        'Event is full',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        canSubscribe ? AppColors.brightRed : Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: canSubscribe
                      ? () => evController.toggleSubscription(index)
                      : null,
                  child: Text(
                    event.subscribed ? 'Unsubscribe' : 'Subscribe',
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
    });
  }

  Widget _buildPastFooter(context, event) {
    FeedbackController fbController = Get.find();
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 16),
        color: AppColors.darkPurple.withAlpha(120),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.mediumPurple,
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
                        event.avgRating.toString(),
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
                          color: AppColors.dimYellow,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brightRed,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () => fbController.navigateTo(context, event),
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
