import 'package:intl/intl.dart';

String formatDateTime(String date) {
  DateTime dateTime = DateTime.parse(date);
  return DateFormat('yyyy MMMM dd HH:mm a').format(dateTime);
}
