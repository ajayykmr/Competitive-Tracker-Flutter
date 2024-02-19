// To parse this JSON data, do
//
//     final userContestSubmissions = userContestSubmissionsFromJson(jsonString);

import 'dart:convert';

import 'package:cflytics/models/return_objects/submission.dart';

UserContestSubmissions userContestSubmissionsFromJson(String str) => UserContestSubmissions.fromJson(json.decode(str));

String userContestSubmissionsToJson(UserContestSubmissions data) => json.encode(data.toJson());

class UserContestSubmissions {
  String? status;
  List<Submission>? result;

  UserContestSubmissions({
    this.status,
    this.result,
  });

  factory UserContestSubmissions.fromJson(Map<String, dynamic> json) => UserContestSubmissions(
    status: json["status"],
    result: json["result"] == null ? [] : List<Submission>.from(json["result"]!.map((x) => Submission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}
