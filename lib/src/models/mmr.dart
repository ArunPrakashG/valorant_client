// To parse this JSON data, do
//
//     final mmr = mmrFromMap(jsonString);

import 'dart:convert';

import 'package:valorant_client/src/models/serializable.dart';

class MMR implements ISerializable<MMR> {
  MMR({
    this.version = 0,
    this.subject = '',
    this.newPlayerExperienceFinished = false,
    this.queueSkills,
    this.latestCompetitiveUpdate,
  });

  final int version;
  final String subject;
  final bool newPlayerExperienceFinished;
  final QueueSkills? queueSkills;
  final LatestCompetitiveUpdate? latestCompetitiveUpdate;

  factory MMR.fromJson(String str) => MMR.fromMap(json.decode(str));

  @override
  Map<String, dynamic> toJson() => toMap();

  factory MMR.fromMap(Map<String, dynamic> json) => MMR(
        version: json["Version"] ?? 0,
        subject: json["Subject"] ?? '',
        newPlayerExperienceFinished: json["NewPlayerExperienceFinished"] ?? false,
        queueSkills: json["QueueSkills"] == null ? null : QueueSkills.fromMap(json["QueueSkills"]),
        latestCompetitiveUpdate: json["LatestCompetitiveUpdate"] == null ? null : LatestCompetitiveUpdate.fromMap(json["LatestCompetitiveUpdate"]),
      );

  Map<String, dynamic> toMap() => {
        "Version": version,
        "Subject": subject,
        "NewPlayerExperienceFinished": newPlayerExperienceFinished,
        "QueueSkills": queueSkills == null ? null : queueSkills!.toMap(),
        "LatestCompetitiveUpdate": latestCompetitiveUpdate == null ? null : latestCompetitiveUpdate!.toMap(),
      };

  @override
  MMR fromJson(Map<String, dynamic> json) {
    return MMR.fromMap(json);
  }
}

class LatestCompetitiveUpdate {
  LatestCompetitiveUpdate({
    this.matchId = '',
    this.matchStartTime = 0,
    this.tierAfterUpdate = 0,
    this.competitiveMovement = '',
  });

  final String matchId;
  final int matchStartTime;
  final int tierAfterUpdate;
  final String competitiveMovement;

  factory LatestCompetitiveUpdate.fromJson(String str) => LatestCompetitiveUpdate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LatestCompetitiveUpdate.fromMap(Map<String, dynamic> json) => LatestCompetitiveUpdate(
        matchId: json["MatchID"] ?? '',
        matchStartTime: json["MatchStartTime"] ?? 0,
        tierAfterUpdate: json["TierAfterUpdate"] ?? 0,
        competitiveMovement: json["CompetitiveMovement"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "MatchID": matchId,
        "MatchStartTime": matchStartTime,
        "TierAfterUpdate": tierAfterUpdate,
        "CompetitiveMovement": competitiveMovement,
      };
}

class QueueSkills {
  QueueSkills({
    this.competitive,
    this.custom,
    this.seeding,
    this.spikerush,
    this.unrated,
  });

  final Competitive? competitive;
  final Competitive? custom;
  final Competitive? seeding;
  final Competitive? spikerush;
  final Competitive? unrated;

  factory QueueSkills.fromJson(String str) => QueueSkills.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QueueSkills.fromMap(Map<String, dynamic> json) => QueueSkills(
        competitive: json["competitive"] == null ? null : Competitive.fromMap(json["competitive"]),
        custom: json["custom"] == null ? null : Competitive.fromMap(json["custom"]),
        seeding: json["seeding"] == null ? null : Competitive.fromMap(json["seeding"]),
        spikerush: json["spikerush"] == null ? null : Competitive.fromMap(json["spikerush"]),
        unrated: json["unrated"] == null ? null : Competitive.fromMap(json["unrated"]),
      );

  Map<String, dynamic> toMap() => {
        "competitive": competitive == null ? null : competitive!.toMap(),
        "custom": custom == null ? null : custom!.toMap(),
        "seeding": seeding == null ? null : seeding!.toMap(),
        "spikerush": spikerush == null ? null : spikerush!.toMap(),
        "unrated": unrated == null ? null : unrated!.toMap(),
      };
}

class Competitive {
  Competitive({
    this.competitiveTier = 0,
    this.totalGamesNeededForRating = 0,
    this.recentGamesNeededForRating = 0,
    //this.seasonalInfoBySeasonId,
  });

  final int competitiveTier;
  final int totalGamesNeededForRating;
  final int recentGamesNeededForRating;
  // disable until i could get time to implement a parsing system to get this data
  //final SeasonalInfoBySeasonId seasonalInfoBySeasonId;

  factory Competitive.fromJson(String str) => Competitive.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Competitive.fromMap(Map<String, dynamic> json) => Competitive(
        competitiveTier: json["CompetitiveTier"] ?? 0,
        totalGamesNeededForRating: json["TotalGamesNeededForRating"] ?? 0,
        recentGamesNeededForRating: json["RecentGamesNeededForRating"] ?? 0,
        //seasonalInfoBySeasonId: json["SeasonalInfoBySeasonID"] == null ? null : SeasonalInfoBySeasonId.fromMap(json["SeasonalInfoBySeasonID"]),
      );

  Map<String, dynamic> toMap() => {
        "CompetitiveTier": competitiveTier,
        "TotalGamesNeededForRating": totalGamesNeededForRating,
        "RecentGamesNeededForRating": recentGamesNeededForRating,
        //"SeasonalInfoBySeasonID": seasonalInfoBySeasonId == null ? null : seasonalInfoBySeasonId.toMap(),
      };
}

/*
class SeasonalInfoBySeasonId {
  SeasonalInfoBySeasonId({
    this.the0Df5Adb94Dcb689913063E9860661Dd3,
    this.empty,
    this.the3F61C7724560Cd3F5D3FA7Ab5Abda6B3,
  });

  final Empty the0Df5Adb94Dcb689913063E9860661Dd3;
  final Empty empty;
  final Empty the3F61C7724560Cd3F5D3FA7Ab5Abda6B3;

  factory SeasonalInfoBySeasonId.fromJson(String str) => SeasonalInfoBySeasonId.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SeasonalInfoBySeasonId.fromMap(Map<String, dynamic> json) => SeasonalInfoBySeasonId(
        the0Df5Adb94Dcb689913063E9860661Dd3:
            json["0df5adb9-4dcb-6899-1306-3e9860661dd3"] == null ? null : Empty.fromMap(json["0df5adb9-4dcb-6899-1306-3e9860661dd3"]),
        empty: json[""] == null ? null : Empty.fromMap(json[""]),
        the3F61C7724560Cd3F5D3FA7Ab5Abda6B3:
            json["3f61c772-4560-cd3f-5d3f-a7ab5abda6b3"] == null ? null : Empty.fromMap(json["3f61c772-4560-cd3f-5d3f-a7ab5abda6b3"]),
      );

  Map<String, dynamic> toMap() => {
        "0df5adb9-4dcb-6899-1306-3e9860661dd3": the0Df5Adb94Dcb689913063E9860661Dd3 == null ? null : the0Df5Adb94Dcb689913063E9860661Dd3.toMap(),
        "": empty == null ? null : empty.toMap(),
        "3f61c772-4560-cd3f-5d3f-a7ab5abda6b3": the3F61C7724560Cd3F5D3FA7Ab5Abda6B3 == null ? null : the3F61C7724560Cd3F5D3FA7Ab5Abda6B3.toMap(),
      };
}
*/

/*
class Empty {
  Empty({
    this.seasonId,
    this.numberOfWins,
    this.topWins,
    this.rankIndex,
    this.capstoneWins,
  });

  final String seasonId;
  final int numberOfWins;
  final List<int> topWins;
  final int rankIndex;
  final int capstoneWins;

  factory Empty.fromJson(String str) => Empty.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Empty.fromMap(Map<String, dynamic> json) => Empty(
        seasonId: json["SeasonID"] ?? null,
        numberOfWins: json["NumberOfWins"] ?? null,
        topWins: json["TopWins"] == null ? null : List<int>.from(json["TopWins"].map((x) => x)),
        rankIndex: json["RankIndex"] ?? null,
        capstoneWins: json["CapstoneWins"] ?? null,
      );

  Map<String, dynamic> toMap() => {
        "SeasonID": seasonId ?? null,
        "NumberOfWins": numberOfWins ?? null,
        "TopWins": topWins == null ? null : List<dynamic>.from(topWins.map((x) => x)),
        "RankIndex": rankIndex ?? null,
        "CapstoneWins": capstoneWins ?? null,
      };
}
*/