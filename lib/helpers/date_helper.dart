import 'package:intl/intl.dart';

class DateHelper {
  static String convertTimeToAmPm(String timestamp) {
    // Parse the input timestamp string to DateTime
    DateTime dateTime = DateTime.parse(timestamp);

    // Format the DateTime to only show time in 12-hour format with AM/PM
    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return formattedTime; // Return only the formatted time
  }

  static String formatDate(String timestamp) {
    DateFormat formatter = DateFormat('yyyy-MM-dd');

    DateTime myDate = DateTime.parse(timestamp);
    formatter.format(myDate);
    var formattedDate = myDate.toString().split(' ')[0];

    return formattedDate;
  }
}
