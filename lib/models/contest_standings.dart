// To parse this JSON data, do
//
//     final contestStandings = contestStandingsFromJson(jsonString);

import 'dart:convert';

import 'package:cflytics/models/return_objects/contest.dart';
import 'package:cflytics/models/return_objects/problem.dart';
import 'package:cflytics/models/return_objects/ranklist_row.dart';

ContestStandings contestStandingsFromJson(String str) => ContestStandings.fromJson(json.decode(str));

String contestStandingsToJson(ContestStandings data) => json.encode(data.toJson());

class ContestStandings {
  String? status;
  Result? result;

  ContestStandings({
    this.status,
    this.result,
  });

  factory ContestStandings.fromJson(Map<String, dynamic> json) => ContestStandings(
    status: json["status"],
    result: json["result"] == null ? null : Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result?.toJson(),
  };
}

class Result {
  Contest? contest;
  List<Problem>? problems;
  List<RanklistRow>? rows;

  Result({
    this.contest,
    this.problems,
    this.rows,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    contest: json["contest"] == null ? null : Contest.fromJson(json["contest"]),
    problems: json["problems"] == null ? [] : List<Problem>.from(json["problems"]!.map((x) => Problem.fromJson(x))),
    rows: json["rows"] == null ? [] : List<RanklistRow>.from(json["rows"]!.map((x) => RanklistRow.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "contest": contest?.toJson(),
    "problems": problems == null ? [] : List<dynamic>.from(problems!.map((x) => x.toJson())),
    "rows": rows == null ? [] : List<dynamic>.from(rows!.map((x) => x.toJson())),
  };
}




