
import 'package:cflytics/models/return_objects/party.dart';
import 'package:cflytics/models/return_objects/problem_result.dart';

class RanklistRow {
  Party? party;
  int? rank;
  double? points;
  int? penalty;
  int? successfulHackCount;
  int? unsuccessfulHackCount;
  List<ProblemResult>? problemResults;

  RanklistRow({
    this.party,
    this.rank,
    this.points,
    this.penalty,
    this.successfulHackCount,
    this.unsuccessfulHackCount,
    this.problemResults,
  });

  factory RanklistRow.fromJson(Map<String, dynamic> json) => RanklistRow(
    party: json["party"] == null ? null : Party.fromJson(json["party"]),
    rank: json["rank"],
    points: json["points"],
    penalty: json["penalty"],
    successfulHackCount: json["successfulHackCount"],
    unsuccessfulHackCount: json["unsuccessfulHackCount"],
    problemResults: json["problemResults"] == null ? [] : List<ProblemResult>.from(json["problemResults"]!.map((x) => ProblemResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "party": party?.toJson(),
    "rank": rank,
    "points": points,
    "penalty": penalty,
    "successfulHackCount": successfulHackCount,
    "unsuccessfulHackCount": unsuccessfulHackCount,
    "problemResults": problemResults == null ? [] : List<dynamic>.from(problemResults!.map((x) => x.toJson())),
  };
}