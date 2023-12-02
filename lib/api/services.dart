import 'dart:convert';
import 'package:competitive_tracker/models/contest_standings.dart';
import 'package:competitive_tracker/models/return_objects/user.dart';
import 'package:competitive_tracker/models/user_contest_submissions.dart';
import 'package:competitive_tracker/models/users_info.dart';
import 'package:competitive_tracker/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import 'package:competitive_tracker/models/contest_list.dart';
import 'package:competitive_tracker/models/return_objects/contest.dart';
import 'package:competitive_tracker/models/return_objects/rating_changes.dart';
import 'package:competitive_tracker/models/return_objects/submission.dart';
import 'package:competitive_tracker/models/user_all_submissions.dart';
import 'package:competitive_tracker/models/user_friends_list.dart';
import 'package:competitive_tracker/models/user_rating_history.dart';

class ApiServices {
  static const baseURL = "https://codeforces.com/api/";

  //https://codeforces.com/api/user.info?handles=qubitt;princemishra01;
  Future<List<User>?> getUsers(List<String> handles) async {
    var url = "${baseURL}user.info?handles=${Constants.userID};";
    final sb = StringBuffer();
    sb.writeAll(handles, ';');
    url = "$url${sb.toString()}";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<User> userList = usersInfoFromJson(response.body).result ?? [];
      return userList;
    }

    return null;
  }

  //https://codeforces.com/api/user.rating?handle=qubitt
  Future<List<RatingChanges>?> getUserRatingHistory(String handles) async {
    final url = "${baseURL}user.rating?handle=$handles";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final ratingChangesList = userRatingHistoryFromJson(response.body).result;
      return ratingChangesList;
    }
    return null;
  }

  //https://codeforces.com/api/user.status?handle=qubitt&from=1&count=10
  Future<List<Submission>?>getUserAllSubmissions(String handle) async {
    final url = "${baseURL}user.status?handle=$handle&from=1&count=50";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<Submission> submissionsList = userAllSubmissionsHistoryFromJson(response.body).result!;
      return submissionsList;
    }

    return null;
  }

  //https://codeforces.com/api/contest.status?contestId=1861&asManager=false&handle=qubitt
  Future<List<Submission>?>getUserContestSubmissions(int contestID, String handle) async {
    final url = "${baseURL}contest.status?contestId=$contestID&asManager=false&handle=$handle";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<Submission> submissionsList = userContestSubmissionsFromJson(response.body).result!;
      return submissionsList;
    }

    return null;
  }

  Future<List<User>?> getFriendsList(String handle) async {
    String apiKey = "c155bc899e8711c9db4c0df97b2c7ce684ba1658";
    String apiSecret = "030ed83c4bfe965728e4cedc068a5c16439fb39c";

    String unixTime = (DateTime.now().millisecondsSinceEpoch~/1000).toString();
    int random = 123456;

    String convertToHex = "$random/user.friends?apiKey=$apiKey&time=$unixTime#$apiSecret";
    String convertedHex = sha512.convert(utf8.encode(convertToHex)).toString().toLowerCase();

    String apiSig = "$random$convertedHex";
    final url = "${baseURL}user.friends"
        "?apiKey=$apiKey"
        "&time=$unixTime"
        "&apiSig=$apiSig";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode==200){
      List<String> friendsListString = userFriendsListFromJson(response.body).result!;
      if (friendsListString.isNotEmpty){
        return getUsers(friendsListString);
      }
    }
    return null;
  }

  //https://codeforces.com/api/contest.list?gym=true
  Future<List<Contest>?> getContestsList() async {
    const url = "${baseURL}contest.list?gym=false";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final contestList = contestListFromJson(response.body).result;
      return contestList;
    }
    return null;
  }

  //https://codeforces.com/api/user.ratedList?activeOnly=true&includeRetired=false
  Future<List<User>?> getLeaderBoard() async {

    const url = "${baseURL}user.ratedList?activeOnly=true&includeRetired=false";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<User> leaderboard = usersInfoFromJson(response.body).result ?? [];
      return leaderboard;
    }

    return null;
  }

  //returns Contest, list of Problems and list of RanklistRow
  //https://codeforces.com/api/contest.standings?contestId=566&asManager=false&from=1&count=5&showUnofficial=true
  Future<ContestStandings?> getContestStandings(int contestID) async {
    final url = "${baseURL}contest.standings?contestId=$contestID&asManager=false&from=1&count=50&showUnofficial=true";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final contestStandings = contestStandingsFromJson(response.body);
      return contestStandings;
    }

    return null;
  }

  //https://codeforces.com/api/contest.standings?contestId=1877&asManager=false&from=1&count=5&showUnofficial=true&handles=qubitt;princemishra01
  Future<ContestStandings?> getContestStandingsFriends(int contestID) async {

    String apiKey = "c155bc899e8711c9db4c0df97b2c7ce684ba1658";
    String apiSecret = "030ed83c4bfe965728e4cedc068a5c16439fb39c";

    String unixTime = (DateTime.now().millisecondsSinceEpoch~/1000).toString();
    int random = 123456;

    String convertToHex = "$random/user.friends?apiKey=$apiKey&time=$unixTime#$apiSecret";
    String convertedHex = sha512.convert(utf8.encode(convertToHex)).toString().toLowerCase();

    String apiSig = "$random$convertedHex";
    final url = "${baseURL}user.friends"
        "?apiKey=$apiKey"
        "&time=$unixTime"
        "&apiSig=$apiSig";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode==200){
      List<String> handles = userFriendsListFromJson(response.body).result!;
      if (handles.isNotEmpty){
        var url2 ="${baseURL}contest.standings?contestId=$contestID&asManager=false&showUnofficial=true&handles=${Constants.userID};";

        final sb = StringBuffer();
        sb.writeAll(handles, ';');
        url2 = "$url2${sb.toString()}";

        final response2 = await http.get(Uri.parse(url2));
        if (response2.statusCode == 200){
          return contestStandingsFromJson(response2.body);
        }
      }
    }

    return null;
  }


}
