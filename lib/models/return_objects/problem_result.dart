class ProblemResult {
  double? points;
  int? rejectedAttemptCount;
  String? type;
  int? bestSubmissionTimeSeconds;

  ProblemResult({
    this.points,
    this.rejectedAttemptCount,
    this.type,
    this.bestSubmissionTimeSeconds,
  });

  factory ProblemResult.fromJson(Map<String, dynamic> json) => ProblemResult(
    points: json["points"],
    rejectedAttemptCount: json["rejectedAttemptCount"],
    type: json["type"],
    bestSubmissionTimeSeconds: json["bestSubmissionTimeSeconds"],
  );

  Map<String, dynamic> toJson() => {
    "points": points,
    "rejectedAttemptCount": rejectedAttemptCount,
    "type": type,
    "bestSubmissionTimeSeconds": bestSubmissionTimeSeconds,
  };
}
