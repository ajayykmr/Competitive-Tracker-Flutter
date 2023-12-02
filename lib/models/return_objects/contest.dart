class Contest {
  int? id;
  String? name;
  String? type;
  String? phase;
  bool? frozen;
  int? durationSeconds;
  String? description;
  int? difficulty;
  String? kind;
  String? season;
  int? startTimeSeconds;
  int? relativeTimeSeconds;
  String? preparedBy;
  String? country;
  String? city;
  String? icpcRegion;
  String? websiteUrl;

  Contest({
    this.id,
    this.name,
    this.type,
    this.phase,
    this.frozen,
    this.durationSeconds,
    this.description,
    this.difficulty,
    this.kind,
    this.season,
    this.startTimeSeconds,
    this.relativeTimeSeconds,
    this.preparedBy,
    this.country,
    this.city,
    this.icpcRegion,
    this.websiteUrl,
  });

  factory Contest.fromJson(Map<String, dynamic> json) => Contest(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    phase: json["phase"],
    frozen: json["frozen"],
    durationSeconds: json["durationSeconds"],
    description: json["description"],
    difficulty: json["difficulty"],
    kind: json["kind"],
    season: json["season"],
    startTimeSeconds: json["startTimeSeconds"],
    relativeTimeSeconds: json["relativeTimeSeconds"],
    preparedBy: json["preparedBy"],
    country: json["country"],
    city: json["city"],
    icpcRegion: json["icpcRegion"],
    websiteUrl: json["websiteUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "phase": phase,
    "frozen": frozen,
    "durationSeconds": durationSeconds,
    "description": description,
    "difficulty": difficulty,
    "kind": kind,
    "season": season,
    "startTimeSeconds": startTimeSeconds,
    "relativeTimeSeconds": relativeTimeSeconds,
    "preparedBy": preparedBy,
    "country": country,
    "city": city,
    "icpcRegion": icpcRegion,
    "websiteUrl": websiteUrl,
  };
}
