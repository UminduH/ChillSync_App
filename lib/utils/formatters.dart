import 'package:intl/intl.dart';

class Formatters {
  static String formatTime(DateTime time){
    final DateFormat timeFormat = DateFormat('hh:mm a');
    return timeFormat.format(time);
  }

  static String formatDate(DateTime date){
    final DateFormat dateFormat = DateFormat('EEEE , MMMM');
    return dateFormat.format(date);
  }

  static String formatDay(DateTime date){
    final DateFormat dateFormat = DateFormat('dd');
    return dateFormat.format(date);
  }
}