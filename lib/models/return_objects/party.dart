
import 'package:competitive_tracker/models/return_objects/member.dart';

class Party {
  int? contestId;
  List<Member>? members;
  String? participantType;
  bool? ghost;
  int? startTimeSeconds;
  int? room;
  int? teamId;
  String? teamName;

  Party({
    this.contestId,
    this.members,
    this.participantType,
    this.ghost,
    this.startTimeSeconds,
    this.room,
    this.teamId,
    this.teamName,
  });

  factory Party.fromJson(Map<String, dynamic> json) => Party(
    contestId: json["contestId"],
    members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
    participantType: json["participantType"],
    ghost: json["ghost"],
    startTimeSeconds: json["startTimeSeconds"],
    room: json["room"],
    teamId: json["teamId"],
    teamName: json["teamName"],
  );

  Map<String, dynamic> toJson() => {
    "contestId": contestId,
    "members": members == null ? [] : List<dynamic>.from(members!.map((x) => x.toJson())),
    "participantType": participantType,
    "ghost": ghost,
    "startTimeSeconds": startTimeSeconds,
    "room": room,
    "teamId": teamId,
    "teamName": teamName,
  };
}