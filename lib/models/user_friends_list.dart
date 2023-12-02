// To parse this JSON data, do
//
//     final userFriendsList = userFriendsListFromJson(jsonString);

import 'dart:convert';

UserFriendsList userFriendsListFromJson(String str) => UserFriendsList.fromJson(json.decode(str));

String userFriendsListToJson(UserFriendsList data) => json.encode(data.toJson());

class UserFriendsList {
  String? status;
  List<String>? result;

  UserFriendsList({
    this.status,
    this.result,
  });

  factory UserFriendsList.fromJson(Map<String, dynamic> json) => UserFriendsList(
    status: json["status"],
    result: json["result"] == null ? [] : List<String>.from(json["result"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x)),
  };
}
