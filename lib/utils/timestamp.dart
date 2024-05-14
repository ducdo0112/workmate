import 'package:flutter/material.dart';
import 'package:workmate/utils/logger.dart';
import 'package:intl/intl.dart';

class TimestampUtil {
  static String getCurrentTimeStamp() {
    DateTime now = DateTime.now();
    return ' timestamp: ${now.hour}:${now.minute}:${now.second}.${now.millisecond}';
  }


  static int getCurrentTimeStampIntType() {
    DateTime now = DateTime.now();
    return (now.millisecondsSinceEpoch)~/1000;
  }

  static int getTimeStampIntType(DateTime dateTime) {
    return (dateTime.millisecondsSinceEpoch)~/1000;
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

  static String formatTimeDDMMYYYY(DateTime dateTime) {
    return DateFormat('ddMMyyyy').format(dateTime);
  }

  static String formatTimeYYYYMMDDWithOutSeparate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static DateTime? convertStringYYYYMMDDToDateTime(String? dateTime) {
    try {
      return DateFormat('yyyy-MM-dd').parse(dateTime!);
    } catch (_) {
      return null;
    }
  }


  static DateTime? convertStringDDMMYYWithSeparateToDateTime(String? dateTime) {
    try {
      return DateFormat('dd/mm/yyyy').parse(dateTime!);
    } catch (_) {
      return null;
    }
  }

  static TimeOfDay? convertStringToTimeOfDay(String? timeString) {
    try {
      List<String>? parts = timeString?.split(':');
      int hour = int.parse(parts![0]);
      int minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return null;
    }
  }

  static String formatTimeHHMM(TimeOfDay time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  static String getNameOfMonthInVietName(DateTime dateTime) {
    switch (dateTime.month) {
      case 1:
        return "Tháng 1";
      case 2:
        return "Tháng 2";
      case 3:
        return "Tháng 3";
      case 4:
        return "Tháng 4";
      case 5:
        return "Tháng 5";
      case 6:
        return "Tháng 6";
      case 7:
        return "Tháng 7";
      case 8:
        return "Tháng 8";
      case 9:
        return "Tháng 9";
      case 10:
        return "Tháng 10";
      case 11:
        return "Tháng 11";
      case 12:
        return "Tháng 12";
      default:
        return "";
    }
  }
}
