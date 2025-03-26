class FeedbackModel {
  final String username;
  final String profilePic;
  final String timestamp;
  final String content;
  final int rating;
  final int votes;

  FeedbackModel({
    required this.username,
    required this.profilePic,
    required this.timestamp,
    required this.content,
    required this.rating,
    required this.votes,
  });
}

class FeedbackCreate extends FeedbackModel {
  FeedbackCreate({
    required super.username,
    required super.profilePic,
    required super.content,
    required super.rating,
  }) : super(timestamp: DateTime.now().toIso8601String(), votes: 0);

  Map<String, dynamic> toJson() => {
    'username': username,
    'comment': content,
    'rating': rating,
  };
}
