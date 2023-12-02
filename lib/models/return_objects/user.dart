class User {
  String? lastName;
  String? country;
  int? lastOnlineTimeSeconds;
  String? city;
  int? rating;
  int? friendOfCount;
  String? titlePhoto;
  String? handle;
  String? avatar;
  String? firstName;
  int? contribution;
  String? organization;
  String? rank;
  int? maxRating;
  int? registrationTimeSeconds;
  String? maxRank;

  User({
    this.lastName,
    this.country,
    this.lastOnlineTimeSeconds,
    this.city,
    this.rating,
    this.friendOfCount,
    this.titlePhoto,
    this.handle,
    this.avatar,
    this.firstName,
    this.contribution,
    this.organization,
    this.rank,
    this.maxRating,
    this.registrationTimeSeconds,
    this.maxRank,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    lastName: json["lastName"] ?? "",
    country: json["country"],
    lastOnlineTimeSeconds: json["lastOnlineTimeSeconds"],
    city: json["city"],
    rating: json["rating"],
    friendOfCount: json["friendOfCount"],
    titlePhoto: json["titlePhoto"],
    handle: json["handle"],
    avatar: json["avatar"],
    firstName: json["firstName"] ?? "",
    contribution: json["contribution"],
    organization: json["organization"],
    rank: json["rank"],
    maxRating: json["maxRating"],
    registrationTimeSeconds: json["registrationTimeSeconds"],
    maxRank: json["maxRank"],
  );

  Map<String, dynamic> toJson() => {
    "lastName": lastName,
    "country": country,
    "lastOnlineTimeSeconds": lastOnlineTimeSeconds,
    "city": city,
    "rating": rating,
    "friendOfCount": friendOfCount,
    "titlePhoto": titlePhoto,
    "handle": handle,
    "avatar": avatar,
    "firstName": firstName,
    "contribution": contribution,
    "organization": organization,
    "rank": rank,
    "maxRating": maxRating,
    "registrationTimeSeconds": registrationTimeSeconds,
    "maxRank": maxRank,
  };
}

