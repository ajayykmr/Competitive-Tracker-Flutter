// To parse this JSON data, do
//
//     final contestList = contestListFromJson(jsonString);

import 'dart:convert';

import 'package:cflytics/models/return_objects/contest.dart';

ContestList contestListFromJson(String str) => ContestList.fromJson(json.decode(str));

String contestListToJson(ContestList data) => json.encode(data.toJson());

class ContestList {
  String? status;
  List<Contest>? result;

  ContestList({
    this.status,
    this.result,
  });

  factory ContestList.fromJson(Map<String, dynamic> json) => ContestList(
    status: json["status"],
    result: json["result"] == null ? [] : List<Contest>.from(json["result"]!.map((x) => Contest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}
