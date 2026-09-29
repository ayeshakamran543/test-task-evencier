import 'package:intl/intl.dart';

class AppDates {
  AppDates._();

  static DateTime dateOnly(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// Monday of the week containing [date].
  static DateTime startOfWeek(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 1));

  /// The seven days (Monday to Sunday) of the week containing [date].
  static List<DateTime> weekOf(DateTime date) {
    final start = startOfWeek(date);
    return List<DateTime>.generate(
      7,
      (i) => DateTime(start.year, start.month, start.day + i),
    );
  }

  /// Whole calendar days from [from] to [to], ignoring time of day and DST.
  static int daysBetween(DateTime from, DateTime to) {
    final a = DateTime.utc(from.year, from.month, from.day);
    final b = DateTime.utc(to.year, to.month, to.day);
    return b.difference(a).inDays;
  }

  static int daysInMonth(DateTime month) =>
      DateTime(month.year, month.month + 1, 0).day;

  /// Empty cells before day 1 in a Monday-first month grid.
  static int leadingBlanks(DateTime month) =>
      DateTime(month.year, month.month, 1).weekday - 1;

  /// "Today, 22 Dec 2024" or "Mon, 23 Dec 2024".
  static String headline(DateTime day, DateTime today) {
    final date = DateFormat('d MMM yyyy').format(day);
    if (isSameDay(day, today)) return 'Today, $date';
    return '${DateFormat('EEE').format(day)}, $date';
  }

  /// "December 9-15", or "Dec 30 - Jan 5" when the week spans two months.
  static String weekRangeLabel(DateTime weekStart) {
    final end = DateTime(weekStart.year, weekStart.month, weekStart.day + 6);
    if (weekStart.month == end.month) {
      return '${DateFormat('MMMM').format(weekStart)} ${weekStart.day}-${end.day}';
    }
    final short = DateFormat('MMM d');
    return '${short.format(weekStart)} - ${short.format(end)}';
  }
}
