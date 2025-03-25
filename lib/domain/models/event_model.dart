class EventModel {
  final String name;
  final String author;
  final DateTime date;
  final String description;
  final String category;
  /* One of:
  - Healthcare & Medicine
  - Business & Finance
  - Science & Engineering
  - Education & Learning
  - Personal Growth & Mindfulness
  */
  final int maxParticipants;
  final int subscribedParticipants;
  final String location;

  EventModel({
    required this.name,
    required this.author,
    required this.date,
    required this.description,
    required this.category,
    required this.maxParticipants,
    required this.subscribedParticipants,
    required this.location,
  });

  // Factory constructor to create an instance of EventModel from JSON
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      name: json['name'],
      author: json['author'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      category: json['category'],
      maxParticipants: json['maxParticipants'],
      subscribedParticipants: json['subscribedParticipants'],
      location: json['location'],
    );
  }

  // Method to convert EventModel instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'author': author,
      'date': date.toIso8601String(),
      'description': description,
      'category': category,
      'maxParticipants': maxParticipants,
      'subscribedParticipants': subscribedParticipants,
      'location': location,
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
