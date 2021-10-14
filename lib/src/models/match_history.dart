// To parse this JSON data, do
//
//     final matchHistory = matchHistoryFromMap(jsonString);

import 'dart:convert';

import 'package:valorant_client/src/models/serializable.dart';

class MatchHistory implements ISerializable<MatchHistory> {
  MatchHistory({
    this.subject,
    this.beginIndex = 0,
    this.endIndex = 0,
    this.total = 0,
    this.history = const [],
  });

  final String? subject;
  final int beginIndex;
  final int endIndex;
  final int total;
  final List<History> history;

  factory MatchHistory.fromJson(String str) => MatchHistory.fromMap(json.decode(str));

  @override
  Map<String, dynamic> toJson() => toMap();

  factory MatchHistory.fromMap(Map<String, dynamic> json) => MatchHistory(
        subject: json["Subject"],
        beginIndex: json["BeginIndex"] ?? 0,
        endIndex: json["EndIndex"] ?? 0,
        total: json["Total"] ?? 0,
        history: json["History"] == null ? [] : List<History>.from(json["History"].map((x) => History.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Subject": subject,
        "BeginIndex": beginIndex,
        "EndIndex": endIndex,
        "Total": total,
        "History": List<dynamic>.from(history.map((x) => x.toMap())),
      };

  @override
  MatchHistory fromJson(Map<String, dynamic> json) {
    return MatchHistory.fromMap(json);
  }
}

class History {
  History({
    this.matchId,
    this.gameStartTime = 0,
    this.teamId,
  });

  final String? matchId;
  final int gameStartTime;
  final String? teamId;

  factory History.fromJson(String str) => History.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory History.fromMap(Map<String, dynamic> json) => History(
        matchId: json["MatchID"],
        gameStartTime: json["GameStartTime"] ?? 0,
        teamId: json["TeamID"],
      );

  Map<String, dynamic> toMap() => {
        "MatchID": matchId,
        "GameStartTime": gameStartTime,
        "TeamID": teamId,
      };
}
