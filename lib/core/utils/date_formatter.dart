import 'package:intl/intl.dart' show DateFormat;

class DateFormatter {
  static String formatDate(DateTime date) => DateFormat('dd MMM yyyy, HH:mm').format(date);
}
