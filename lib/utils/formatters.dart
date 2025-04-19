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

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.startsWith("+94")) {
      // ignore: prefer_interpolation_to_compose_strings
      return '0' + phoneNumber.substring(3);
    }

    return phoneNumber;
  }

  static String getMaskedPhoneNumber(String? phoneNumber) {
    String formatPhone = Formatters.formatPhoneNumber(phoneNumber!);
    int starsCount = formatPhone.length - 6;
    return formatPhone.substring(0, 3) + ('*' * starsCount) + formatPhone.substring(formatPhone.length - 3);
  }
}