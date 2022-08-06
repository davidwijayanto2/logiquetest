import 'package:intl/intl.dart';

class DateFormatter {
  static String toShortTimeText(DateTime date) {
    return DateFormat('HH:mm:ss').format(date);
  }

  static String toShortDateText(context, DateTime date) {
    return DateFormat('dd ').format(date) +
        DateFormat.MMM().format(date) +
        DateFormat(' yyyy').format(date);
  }

  static String toLongDateText(context, DateTime date) {
    return DateFormat('dd ').format(date) +
        DateFormat.MMMM().format(date) +
        DateFormat(' yyyy').format(date);
  }
}
