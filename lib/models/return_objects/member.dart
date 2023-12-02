class Member {
  String? handle;

  Member({
    this.handle,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    handle: json["handle"],
  );

  Map<String, dynamic> toJson() => {
    "handle": handle,
  };
}
