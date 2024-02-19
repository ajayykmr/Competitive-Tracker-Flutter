// To parse this JSON data, do
//
//     final userAllSubmissionsHistory = userAllSubmissionsHistoryFromJson(jsonString);

import 'dart:convert';

import 'package:cflytics/models/return_objects/submission.dart';

UserAllSubmissionsHistory userAllSubmissionsHistoryFromJson(String str) => UserAllSubmissionsHistory.fromJson(json.decode(str));

String userAllSubmissionsHistoryToJson(UserAllSubmissionsHistory data) => json.encode(data.toJson());

class UserAllSubmissionsHistory {
  String? status;
  List<Submission>? result;

  UserAllSubmissionsHistory({
    this.status,
    this.result,
  });

  factory UserAllSubmissionsHistory.fromJson(Map<String, dynamic> json) => UserAllSubmissionsHistory(
    status: json["status"],
    result: json["result"] == null ? [] : List<Submission>.from(json["result"]!.map((x) => Submission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

