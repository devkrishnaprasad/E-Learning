import 'dart:developer';
import 'package:intl/intl.dart';

class Warppers {
  String convertMinutesToHours(String minutes) {
    try {
      int totalMinutes = int.parse(minutes);

      if (totalMinutes < 60) {
        return "$totalMinutes min";
      }

      double hours = totalMinutes / 60.0;
      int roundedHours = hours.round();

      String result = "$roundedHours hr";

      return result;
    } catch (e) {
      log("Error $e");
      return "NA";
    }
  }

  String timeAgo(String date) {
    DateTime givenDate = DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'")
        .parse(date, true)
        .toLocal();
    DateTime now = DateTime.now();

    Duration difference = now.difference(givenDate);

    if (difference.inDays >= 14) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays >= 7) {
      return '1 week ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }
}
