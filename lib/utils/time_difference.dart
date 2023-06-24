String timeDifference(currentTimeString, alertTimeString) {
  // String currentTimeString = DateFormat('hh:mm:ss').format(DateTime.now());
  DateTime currentTime = DateTime.parse('2000-01-01 $currentTimeString');
  DateTime alertTime = DateTime.parse('2000-01-01 $alertTimeString');

  Duration difference = currentTime.difference(alertTime);

  if (difference.inHours < 1) {
    return "${difference.inMinutes.remainder(60)}m ago";
  } else {
    return "${difference.inHours}h ${difference.inMinutes.remainder(60)}m ago";
  }
}
