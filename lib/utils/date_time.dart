import 'package:intl/intl.dart';

String getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays >= 365) {
    final years = (difference.inDays / 365).floor();
    return '$years year${years > 1 ? 's' : ''} ago';
  } else if (difference.inDays >= 30) {
    final months = (difference.inDays / 30).floor();
    return '$months month${months > 1 ? 's' : ''} ago';
  } else if (difference.inDays >= 1) {
    return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
  } else if (difference.inHours >= 1) {
    return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
  } else if (difference.inMinutes >= 1) {
    return '''${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago''';
  } else {
    return 'Just now';
  }
}

List<String> getLast7Days() {
  final daysList = <String>[];
  final today = DateTime.now();

  for (var i = 0; i < 7; i++) {
    final date = today.subtract(Duration(days: i));
    final formattedDate = _formatDate(date);
    daysList.add(formattedDate);
  }

  return daysList;
}

String formatDate(DateTime dateTime) {
  final dateFormat = DateFormat('MMM. d, yyyy');
  return dateFormat.format(dateTime);
}

String fullDateFormat(String inputDate) {
  var day = inputDate;
  final currentYear = DateTime.now().year;

  if (inputDate == 'Today') {
    day = DateFormat('d MMM').format(DateTime.now());
  }

  if (inputDate == 'Yesterday') {
    day = DateFormat('d MMM')
        .format(DateTime.now().subtract(const Duration(days: 1)));
  }

  // Parse the input date in the 'd MMM' format
  final inputDateFormat = DateFormat('d MMM');
  final parsedDate = inputDateFormat.parse(day);

  // Combine the current year with the parsed date
  final formattedDate = DateTime(currentYear, parsedDate.month, parsedDate.day);

  // Format the combined date in the 'yyyy-MM-dd' format
  final outputDateFormat = DateFormat('yyyy-MM-dd');
  final formattedDateString = outputDateFormat.format(formattedDate);

  return '${formattedDateString}T00:00:00';
}

String _formatDate(DateTime date) {
  if (_isToday(date)) {
    return 'Today';
  } else if (_isYesterday(date)) {
    return 'Yesterday';
  } else {
    return DateFormat('d MMM').format(date);
  }
}

bool _isToday(DateTime date) {
  final now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}

bool _isYesterday(DateTime date) {
  final now = DateTime.now();
  final yesterday = now.subtract(const Duration(days: 1));
  return date.year == yesterday.year &&
      date.month == yesterday.month &&
      date.day == yesterday.day;
}

bool compareDates(DateTime date1, DateTime date2) {
  // Compare the year, month, and day components of the two DateTime objects
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

DateTime dayToDate(String day) {
  final today = DateTime.now();
  if (day == 'Today') {
    return today;
  } else if (day == 'Yesterday') {
    return today.subtract(const Duration(days: 1));
  } else {
    final parsedDate = DateFormat('d MMM').parse(day);

    return DateTime(today.year, parsedDate.month, parsedDate.day);
  }
}
