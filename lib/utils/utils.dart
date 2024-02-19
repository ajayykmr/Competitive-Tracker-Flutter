import 'package:cflytics/models/return_objects/problem.dart';
import 'package:cflytics/models/return_objects/submission.dart';
import 'package:cflytics/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  Utils._();

  static String capitalizeFirstLetterFunction(String s) => s[0].toUpperCase() + s.substring(1);

  static String monthFromInteger(int month){

    switch(month){
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case _:
        return "Dec";
    }
  }
  static Color ratingColor(int rating)
  {
    switch(rating){
      case <1200:             return AppColor.newbie;
      case >=1200 && <1400:   return AppColor.pupil;
      case >=1400 && <1600:   return AppColor.specialist;
      case >=1600 && <1900:   return AppColor.expert;
      case >=1900 && <2100:   return AppColor.candidateMaster;
      case >=2100 && <2300:   return AppColor.master;
      case >=2300 && <2400:   return AppColor.internationalMaster;
      case >=2400 && <2600:   return AppColor.grandmaster;
      case >=2600 && <3000:   return AppColor.internationalGrandmaster;
      case _:                 return AppColor.legendaryGrandmaster;
    }
  }

  static String ratingDelta(int newRating, int oldRating){
    if (newRating-oldRating>=0) {
      return "+${newRating-oldRating}";
    } else {
      return (newRating-oldRating).toString();
    }
  }

  static openSubmission(Submission sub) async {
    final url = "https://codeforces.com/contest/${sub.contestId}/submission/${sub.id}";
    final uri = Uri.parse(url);
    launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }

  //https://codeforces.com/contest/1891/problem/A
  static openProblem(Problem problem) async {
    final url = "https://codeforces.com/contest/${problem.contestId}/problem/${problem.index}";
    final uri = Uri.parse(url);
    launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }

  static DateTime getDateTimeFromEpochSeconds(int epochTime){
    return DateTime.fromMillisecondsSinceEpoch(epochTime*1000);
  }

  static String getDateStringFromEpochSeconds(int epochTime){
    DateTime dateTime = getDateTimeFromEpochSeconds(epochTime);

    String day = dateTime.day.toString();
    String month = dateTime.month.toString();
    String year = dateTime.year.toString();

    if (day.length==1) {
      day = "0$day";
    }
    if (month.length==1){
      month = "0$month";
    }

    return "$day-$month-$year";
  }

  static String getTimeStringFromEpochSeconds(int epochTime){
    DateTime dateTime = getDateTimeFromEpochSeconds(epochTime);

    if (dateTime.minute < 10) {
      return "${dateTime.hour}:0${dateTime.minute}";
    } else {
      return "${dateTime.hour}:${dateTime.minute}";
    }
  }

  static String capitalizeFirstLetter(String s) => s[0].toUpperCase() + s.substring(1);

  static String getTimeStringFromSeconds(int seconds) {

    //2147483647
    if (seconds==2147483647){
      return "--:--";
    }
    final Duration d = Duration(seconds: seconds);

    String hours = d.inHours.toString();
    String minutes = (d.inMinutes%60).toString();

    if (hours.length==1){
      hours = "0$hours";
    }
    if (minutes.length==1){
      minutes = "0$minutes";
    }

    return "$hours:$minutes";
  }

}


