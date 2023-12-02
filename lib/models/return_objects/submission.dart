import 'package:competitive_tracker/models/return_objects/author.dart';
import 'package:competitive_tracker/models/return_objects/problem.dart';

class Submission {
  int? id;
  int? contestId;
  int? creationTimeSeconds;
  int? relativeTimeSeconds;
  Problem? problem;
  Author? author;
  String? programmingLanguage;
  String? verdict;
  String? testset;
  int? passedTestCount;
  int? timeConsumedMillis;
  int? memoryConsumedBytes;

  Submission({
    this.id,
    this.contestId,
    this.creationTimeSeconds,
    this.relativeTimeSeconds,
    this.problem,
    this.author,
    this.programmingLanguage,
    this.verdict,
    this.testset,
    this.passedTestCount,
    this.timeConsumedMillis,
    this.memoryConsumedBytes,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
    id: json["id"],
    contestId: json["contestId"],
    creationTimeSeconds: json["creationTimeSeconds"],
    relativeTimeSeconds: json["relativeTimeSeconds"],
    problem: json["problem"] == null ? null : Problem.fromJson(json["problem"]),
    author: json["author"] == null ? null : Author.fromJson(json["author"]),
    programmingLanguage: json["programmingLanguage"],
    verdict: json["verdict"],
    testset: json["testset"],
    passedTestCount: json["passedTestCount"],
    timeConsumedMillis: json["timeConsumedMillis"],
    memoryConsumedBytes: json["memoryConsumedBytes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "contestId": contestId,
    "creationTimeSeconds": creationTimeSeconds,
    "relativeTimeSeconds": relativeTimeSeconds,
    "problem": problem?.toJson(),
    "author": author?.toJson(),
    "programmingLanguage": programmingLanguage,
    "verdict": verdict,
    "testset": testset,
    "passedTestCount": passedTestCount,
    "timeConsumedMillis": timeConsumedMillis,
    "memoryConsumedBytes": memoryConsumedBytes,
  };
}


