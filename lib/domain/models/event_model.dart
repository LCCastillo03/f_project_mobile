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
  static const List<String> categories = ["Healthcare", "Business", "Science", "Education", "Personal Growth"];

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
    this.avgRating,
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
