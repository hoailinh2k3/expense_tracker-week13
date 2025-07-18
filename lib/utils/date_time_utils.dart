import 'package:intl/intl.dart';

class DateTimeUtils {
  static String format(DateTime date) {
    return DateFormat.yMMMd().format(date);
  }
}
