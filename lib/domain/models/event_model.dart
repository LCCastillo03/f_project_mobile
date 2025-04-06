import 'package:project/domain/models/schedule_item.dart';

class EventModel {
  final String id;
  final String name;
  final String author;
  final DateTime date;
  final String description;
  final String category;
  /* One of:
  - Healthcare
  - Business
  - Science
  - Education
  - Personal Growth
  */
  final int maxParticipants;
  final int subscribedParticipants;
  final String location;
  final double? avgRating;
  bool subscribed;
  final List<ScheduleItem> schedule;

  EventModel({
    required this.id,
    required this.name,
    required this.author,
    required this.date,
    required this.description,
    required this.category,
    required this.maxParticipants,
    required this.subscribedParticipants,
    required this.location,
    this.avgRating = 0,
    this.subscribed = false,
    required this.schedule,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      category: json['category'],
      maxParticipants: json['maxParticipants'],
      subscribedParticipants: json['subscribedParticipants'],
      location: json['location'],
      avgRating: json['avgRating'],
      schedule: (json['schedule'] ?? [])
          .map<ScheduleItem>((item) => ScheduleItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'date': date.toIso8601String(),
      'description': description,
      'category': category,
      'maxParticipants': maxParticipants,
      'subscribedParticipants': subscribedParticipants,
      'location': location,
      'avgRating': avgRating,
      'schedule': schedule.map((e) => e.toJson()).toList(),
    };
  }

  String eventDecorationImagePath() {
    switch (category) {
      case 'Business':
        return 'assets/images/buildings.png';
      case 'Science':
        return 'assets/images/stars.png';
      case 'Education':
        return 'assets/images/atomic.png';
      case 'Personal Growth':
        return 'assets/images/laterns-beach.png';
      default:
        return 'assets/images/laterns-beach.png';
    }
  }

  bool isPast() {
    return date.isBefore(DateTime.now());
  }
}
