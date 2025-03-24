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