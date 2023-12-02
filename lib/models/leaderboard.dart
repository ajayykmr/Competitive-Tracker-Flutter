
import 'dart:convert';

import 'return_objects/user.dart';

LeaderBoard leaderBoardFromJson(String str) => LeaderBoard.fromJson(json.decode(str));

String leaderBoardToJson(LeaderBoard data) => json.encode(data.toJson());

class LeaderBoard {
  String? status;
  List<User>? result;

  LeaderBoard({
    this.status,
    this.result,
  });

  factory LeaderBoard.fromJson(Map<String, dynamic> json) => LeaderBoard(
    status: json["status"],
    result: json["result"] == null ? [] : List<User>.from(json["result"]!.map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

