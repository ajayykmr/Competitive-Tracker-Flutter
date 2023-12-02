// To parse this JSON data, do
//
//     final userRatingChanges = userRatingChangesFromJson(jsonString);

import 'dart:convert';

import 'return_objects/rating_changes.dart';

UserRatingHistory userRatingHistoryFromJson(String str) => UserRatingHistory.fromJson(json.decode(str));

String userRatingHistoryToJson(UserRatingHistory data) => json.encode(data.toJson());

class UserRatingHistory {
  String? status;
  List<RatingChanges>? result;

  UserRatingHistory({
    this.status,
    this.result,
  });

  factory UserRatingHistory.fromJson(Map<String, dynamic> json) => UserRatingHistory(
    status: json["status"],
    result: json["result"] == null ? [] : List<RatingChanges>.from(json["result"]!.map((x) => RatingChanges.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}