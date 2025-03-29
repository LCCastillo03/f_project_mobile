String clipText(text, chars) {
  return text.length > chars ? '${text.substring(0, chars)}...' : text;
}

String getTimestamp(date) {
  Duration diff = DateTime.now().difference(date);
  String suffix = diff.isNegative ? 'away' : 'ago';
  diff = diff.abs();
  String pluralize(int value, String unit) =>
      '$value $unit${value > 1 ? 's' : ''}';

  if (diff.inDays > 365) {
    return '${pluralize((diff.inDays / 365).floor(), 'year')} $suffix';
  } else if (diff.inDays > 30) {
    return '${pluralize((diff.inDays / 30).floor(), 'month')} $suffix';
  } else if (diff.inDays > 0) {
    return '${pluralize(diff.inDays, 'day')} $suffix';
  } else if (diff.inHours > 0) {
    return '${pluralize(diff.inHours, 'hour')} $suffix';
  } else if (diff.inMinutes > 0) {
    return '${pluralize(diff.inMinutes, 'minute')} $suffix';
  } else {
    return '${pluralize(diff.inSeconds, 'second')} $suffix';
  }
}

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour >= 5 && hour < 12) {
    return 'Good Morning!';
  } else if (hour >= 12 && hour < 18) {
    return 'Good Afternoon!';
  } else {
    return 'Good Evening!';
  }
}

List<String> getAvatarPaths() {
  return List.generate(5, (index) => 'assets/images/avatars/avatar-$index.jpg');
}