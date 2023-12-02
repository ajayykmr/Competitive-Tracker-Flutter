// To parse this JSON data, do
//
//     final usersInfo = usersInfoFromJson(jsonString);

import 'dart:convert';

import 'return_objects/user.dart';

UsersInfo usersInfoFromJson(String str) => UsersInfo.fromJson(json.decode(str));

String usersInfoToJson(UsersInfo data) => json.encode(data.toJson());

class UsersInfo {
  String? status;
  List<User>? result;

  UsersInfo({
    this.status,
    this.result,
  });

  factory UsersInfo.fromJson(Map<String, dynamic> json) => UsersInfo(
    status: json["status"],
    result: json["result"] == null ? [] : List<User>.from(json["result"]!.map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

