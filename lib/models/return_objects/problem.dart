class Problem {
  int? contestId;
  String? index;
  String? name;
  String? type;
  double? points;
  int? rating;
  List<String>? tags;

  Problem({
    this.contestId,
    this.index,
    this.name,
    this.type,
    this.points,
    this.rating,
    this.tags,
  });

  factory Problem.fromJson(Map<String, dynamic> json) => Problem(
    contestId: json["contestId"],
    index: json["index"],
    name: json["name"],
    type: json["type"],
    points: json["points"],
    rating: json["rating"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "contestId": contestId,
    "index": index,
    "name": name,
    "type": type,
    "points": points,
    "rating": rating,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
  };
}