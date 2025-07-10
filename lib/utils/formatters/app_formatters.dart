import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

//! ---> formate data
  static String formateDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

//! ---> formate currency
  static String formateCurrency(double amount) {
    return NumberFormat.currency(locale: 'en-Us', symbol: "\$").format(amount);
  }

//! ---> formate phone number
  static String formatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return "(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}";
    } else if (phoneNumber.length == 11) {
      return "(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}";
    }
    return phoneNumber;
  }
}
