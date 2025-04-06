class ScheduleItem {
  final String time;
  final String topic;
  final String description;

  ScheduleItem({
    required this.time,
    required this.topic,
    required this.description,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) {
    return ScheduleItem(
      time: json['time'],
      topic: json['topic'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'topic': topic,
      'description': description,
    };
  }
}
