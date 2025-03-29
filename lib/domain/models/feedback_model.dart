class FeedbackModel {
  final String username;
  final String profilePic;
  final DateTime date;
  final String content;
  final int rating;
  final int votes;

  FeedbackModel({
    required this.username,
    required this.profilePic,
    required this.date,
    required this.content,
    required this.rating,
    required this.votes,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      username: json['username'] as String,
      profilePic: json['profilePic'] as String,
      date: DateTime.parse(json['date']),
      content: json['content'] as String,
      rating: json['rating'] as int,
      votes: json['votes'] as int,
    );
  }

  String getTimestamp() {
    Duration diff = DateTime.now().difference(date);
    if (diff.inDays > 365) {
      return '${(diff.inDays/365).floor()} day${(diff.inDays/365).floor() > 1 ? 's' : ''} ago';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hour${diff.inHours > 1 ? 's' : ''} ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minute${diff.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return '${diff.inSeconds} second${diff.inSeconds > 1 ? 's' : ''} ago';
    }
  }
}

class FeedbackCreate extends FeedbackModel {
  FeedbackCreate({
    required super.username,
    required super.profilePic,
    required super.content,
    required super.rating,
  }) : super(date: DateTime.now(), votes: 0);
}
