import 'package:intl/intl.dart';

class DateFormatter {
  // Format date as 'DD/MM/YYYY'
  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  // Format date as 'Month DD, YYYY'
  static String formatFullDate(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  // Format date as 'Day, Month DD'
  static String formatDayMonth(DateTime date) {
    return DateFormat('EEEE, MMMM dd').format(date);
  }

  // Format time as 'HH:MM AM/PM'
  static String formatTime(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  // Format date and time as 'DD/MM/YYYY HH:MM AM/PM'
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
  }

  // Format date and time for exam schedule
  static String formatExamDateTime(DateTime dateTime) {
    return DateFormat('EEEE, MMMM dd, yyyy • hh:mm a').format(dateTime);
  }

  // Format as relative time (e.g., "2 days ago", "just now")
  static String getRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} year(s) ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} month(s) ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day(s) ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour(s) ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute(s) ago';
    } else {
      return 'Just now';
    }
  }

  // Format time range (e.g., "09:00 AM - 10:30 AM")
  static String formatTimeRange(String startTime, String endTime) {
    return '$startTime - $endTime';
  }

  // Get remaining days until a date
  static int getRemainingDays(DateTime dueDate) {
    final now = DateTime.now();
    final difference = dueDate.difference(now).inDays;
    return difference > 0 ? difference : 0;
  }

  // Get formatted remaining time (e.g., "2 days left")
  static String getFormattedRemainingTime(DateTime dueDate) {
    final remainingDays = getRemainingDays(dueDate);

    if (remainingDays == 0) {
      return 'Due today';
    } else if (remainingDays == 1) {
      return '1 day left';
    } else {
      return '$remainingDays days left';
    }
  }

  // Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  // Check if date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year && date.month == tomorrow.month && date.day == tomorrow.day;
  }
}