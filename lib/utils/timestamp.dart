import 'package:workmate/utils/logger.dart';
import 'package:intl/intl.dart';

class Timestamp {
  static String getCurrentTimeStamp() {
    DateTime now = DateTime.now();
    return ' timestamp: ${now.hour}:${now.minute}:${now.second}.${now.millisecond}';
  }

  static String getCurrentTimeStampInMilliseconds() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static String getTimeZone() {
    return DateTime.now().timeZoneName;
  }

  static String convertTimeVisitHistory({required String time}) {
    try {
      return DateFormat('y年M月d日 hh時mm分', 'ja').format(DateTime.parse(time));
    } catch (e) {
      logger.e("Error when convert time visit history: $e");
      return '';
    }
  }

  static String convertTimeVisitHistoryFromMilliseconds(
      {required String time}) {
    try {
      return DateFormat('y年M月d日 HH時mm分', 'ja')
          .format(DateTime.fromMillisecondsSinceEpoch(int.parse(time)));
    } catch (e) {
      logger.e("Error when convert time visit history: $e");
      return '';
    }
  }

  /// input must be: yyyy-mm-dd
  static String getNumberDayTimeRemainworkmate(String time) {
    try {
      final timeworkmateInDay = DateTime.parse(time).day;
      final currentTimeInDay = DateTime.now().day;
      if (timeworkmateInDay > currentTimeInDay) {
        return (timeworkmateInDay - currentTimeInDay).toString();
      }
      return '0';
    } catch (e) {
      logger.e("Error when convert time visit history: $e");
      return '0';
    }
  }

  static int getNumberDayTimeRemainworkmateWithIntValue(String time) {
    try {
      final timeworkmateInDay = DateTime.parse(time).day;
      final currentTimeInDay = DateTime.now().day;
      return timeworkmateInDay - currentTimeInDay;
    } catch (e) {
      logger.e("Error when convert time visit history: $e");
      return -1;
    }
  }

  static int daysBetween(String time) {
    try {
      var from = DateTime.now();
      var to = DateTime.parse(time);
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    } catch (e) {
      logger.e('Error when get daysBetween: $time');
      return -1;
    }
  }
}
