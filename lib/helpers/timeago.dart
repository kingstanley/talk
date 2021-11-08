String timeAgo(DateTime input) {
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    if (diff.inDays > 1 && diff.inDays <= 6) {
      return weekday[input.weekday];
    }
    if (diff.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${diff.inDays} day(s) ago';
    }
  } else if (diff.inHours == 1) {
    return '${diff.inHours} hour ago';
  } else if (diff.inHours > 1) {
    return '${diff.inHours} hours ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} min ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} sec ago';
  } else {
    return 'Just now';
  }
}

final weekday = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Sartuday',
  'Sunday'
];
