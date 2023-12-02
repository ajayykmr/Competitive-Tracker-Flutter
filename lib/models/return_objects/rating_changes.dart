class RatingChanges {
  int? contestId;
  String? contestName;
  String? handle;
  int? rank;
  int? ratingUpdateTimeSeconds;
  int? oldRating;
  int? newRating;

  RatingChanges({
    this.contestId,
    this.contestName,
    this.handle,
    this.rank,
    this.ratingUpdateTimeSeconds,
    this.oldRating,
    this.newRating,
  });

  factory RatingChanges.fromJson(Map<String, dynamic> json) => RatingChanges(
    contestId: json["contestId"],
    contestName: json["contestName"],
    handle: json["handle"],
    rank: json["rank"],
    ratingUpdateTimeSeconds: json["ratingUpdateTimeSeconds"],
    oldRating: json["oldRating"],
    newRating: json["newRating"],
  );

  Map<String, dynamic> toJson() => {
    "contestId": contestId,
    "contestName": contestName,
    "handle": handle,
    "rank": rank,
    "ratingUpdateTimeSeconds": ratingUpdateTimeSeconds,
    "oldRating": oldRating,
    "newRating": newRating,
  };
}
