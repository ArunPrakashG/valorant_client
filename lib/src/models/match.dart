import 'dart:convert';

import 'package:valorant_client/src/models/serializable.dart';

class Match implements ISerializable<Match> {
  Match({
    this.matchInfo,
    this.players = const [],
    this.teams = const [],
    this.roundResults = const [],
    this.kills = const [],
  });

  final MatchInfo? matchInfo;
  final List<Player> players;
  final List<Team> teams;
  final List<RoundResultElement> roundResults;
  final List<Kill> kills;

  factory Match.fromJson(String str) => Match.fromMap(json.decode(str));

  @override
  Map<String, dynamic> toJson() => toMap();

  factory Match.fromMap(Map<String, dynamic> json) => Match(
        matchInfo: json["matchInfo"] != null ? MatchInfo.fromMap(json["matchInfo"]) : null,
        players: json["players"] != null ? List<Player>.from(json["players"].map((x) => Player.fromMap(x))) : [],
        teams: json["teams"] != null ? List<Team>.from(json["teams"].map((x) => Team.fromMap(x))) : [],
        roundResults: json["roundResults"] != null ? List<RoundResultElement>.from(json["roundResults"].map((x) => RoundResultElement.fromMap(x))) : [],
        kills: json["kills"] != null ? List<Kill>.from(json["kills"].map((x) => Kill.fromMap(x))) : [],
      );

  Map<String, dynamic> toMap() => {
        "matchInfo": matchInfo?.toMap(),
        "players": List<dynamic>.from(players.map((x) => x.toMap())),
        "teams": List<dynamic>.from(teams.map((x) => x.toMap())),
        "roundResults": List<dynamic>.from(roundResults.map((x) => x.toMap())),
        "kills": List<dynamic>.from(kills.map((x) => x.toMap())),
      };

  @override
  Match fromJson(Map<String, dynamic> json) {
    return Match.fromMap(json);
  }
}

class Kill {
  Kill({
    this.gameTime = 0,
    this.roundTime = 0,
    this.round = 0,
    this.killer,
    this.victim,
    this.victimLocation,
    this.assistants = const [],
    this.playerLocations = const [],
    this.finishingDamage,
  });

  final int gameTime;
  final int roundTime;
  final int round;
  final String? killer;
  final String? victim;
  final Location? victimLocation;
  final List<String> assistants;
  final List<PlayerLocation> playerLocations;
  final FinishingDamage? finishingDamage;

  factory Kill.fromJson(String str) => Kill.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Kill.fromMap(Map<String, dynamic> json) => Kill(
        gameTime: json["gameTime"] ?? 0,
        roundTime: json["roundTime"] ?? 0,
        round: json["round"] ?? 0,
        killer: json["killer"],
        victim: json["victim"],
        victimLocation: json["victimLocation"] != null ? Location.fromMap(json["victimLocation"]) : null,
        assistants: json["assistants"] == null ? [] : List<String>.from(json["assistants"].map((x) => x)),
        playerLocations: json["playerLocations"] == null ? [] : List<PlayerLocation>.from(json["playerLocations"].map((x) => PlayerLocation.fromMap(x))),
        finishingDamage: json["finishingDamage"] == null ? null : FinishingDamage.fromMap(json["finishingDamage"]),
      );

  Map<String, dynamic> toMap() => {
        "gameTime": gameTime,
        "roundTime": roundTime,
        "round": round,
        "killer": killer,
        "victim": victim,
        "victimLocation": victimLocation?.toMap(),
        "assistants": List<dynamic>.from(assistants.map((x) => x)),
        "playerLocations": List<dynamic>.from(playerLocations.map((x) => x.toMap())),
        "finishingDamage": finishingDamage?.toMap(),
      };
}

class FinishingDamage {
  FinishingDamage({
    this.damageType,
    this.damageItem,
    this.isSecondaryFireMode = false,
  });

  final String? damageType;
  final String? damageItem;
  final bool isSecondaryFireMode;

  factory FinishingDamage.fromJson(String str) => FinishingDamage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FinishingDamage.fromMap(Map<String, dynamic> json) => FinishingDamage(
        damageType: json["damageType"],
        damageItem: json["damageItem"],
        isSecondaryFireMode: json["isSecondaryFireMode"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "damageType": damageType,
        "damageItem": damageItem,
        "isSecondaryFireMode": isSecondaryFireMode,
      };
}

class PlayerLocation {
  PlayerLocation({
    this.subject,
    this.viewRadians = 0,
    this.location,
  });

  final String? subject;
  final double viewRadians;
  final Location? location;

  factory PlayerLocation.fromJson(String str) => PlayerLocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayerLocation.fromMap(Map<String, dynamic> json) => PlayerLocation(
        subject: json["subject"],
        viewRadians: json["viewRadians"] == null ? 0 : json["viewRadians"].toDouble(),
        location: json["location"] == null ? null : Location.fromMap(json["location"]),
      );

  Map<String, dynamic> toMap() => {
        "subject": subject,
        "viewRadians": viewRadians,
        "location": location?.toMap(),
      };
}

class Location {
  Location({
    this.x = 0,
    this.y = 0,
  });

  final int x;
  final int y;

  factory Location.fromJson(String str) => Location.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Location.fromMap(Map<String, dynamic> json) => Location(
        x: json["x"] ?? 0,
        y: json["y"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "x": x,
        "y": y,
      };
}

class MatchInfo {
  MatchInfo({
    this.matchId,
    this.mapId,
    this.gamePodId,
    this.gameLoopZone,
    this.gameServerAddress,
    this.gameVersion,
    this.gameLengthMillis = 0,
    this.gameStartMillis = 0,
    this.provisioningFlowId,
    this.isCompleted = false,
    this.customGameName,
    this.forcePostProcessing = false,
    this.queueId,
    this.gameMode,
    this.isRanked = false,
    this.canProgressContracts = false,
    this.isMatchSampled = false,
    this.seasonId,
    this.completionState,
    this.platformType,
  });

  final String? matchId;
  final String? mapId;
  final String? gamePodId;
  final String? gameLoopZone;
  final String? gameServerAddress;
  final String? gameVersion;
  final int gameLengthMillis;
  final int gameStartMillis;
  final String? provisioningFlowId;
  final bool isCompleted;
  final String? customGameName;
  final bool forcePostProcessing;
  final String? queueId;
  final String? gameMode;
  final bool isRanked;
  final bool canProgressContracts;
  final bool isMatchSampled;
  final String? seasonId;
  final String? completionState;
  final String? platformType;

  factory MatchInfo.fromJson(String str) => MatchInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MatchInfo.fromMap(Map<String, dynamic> json) => MatchInfo(
        matchId: json["matchId"],
        mapId: json["mapId"],
        gamePodId: json["gamePodId"],
        gameLoopZone: json["gameLoopZone"],
        gameServerAddress: json["gameServerAddress"],
        gameVersion: json["gameVersion"],
        gameLengthMillis: json["gameLengthMillis"] ?? 0,
        gameStartMillis: json["gameStartMillis"] ?? 0,
        provisioningFlowId: json["provisioningFlowID"],
        isCompleted: json["isCompleted"] ?? false,
        customGameName: json["customGameName"],
        forcePostProcessing: json["forcePostProcessing"] ?? false,
        queueId: json["queueID"],
        gameMode: json["gameMode"],
        isRanked: json["isRanked"] ?? false,
        canProgressContracts: json["canProgressContracts"] ?? false,
        isMatchSampled: json["isMatchSampled"] ?? false,
        seasonId: json["seasonId"],
        completionState: json["completionState"],
        platformType: json["platformType"],
      );

  Map<String, dynamic> toMap() => {
        "matchId": matchId,
        "mapId": mapId,
        "gamePodId": gamePodId,
        "gameLoopZone": gameLoopZone,
        "gameServerAddress": gameServerAddress,
        "gameVersion": gameVersion,
        "gameLengthMillis": gameLengthMillis,
        "gameStartMillis": gameStartMillis,
        "provisioningFlowID": provisioningFlowId,
        "isCompleted": isCompleted,
        "customGameName": customGameName,
        "forcePostProcessing": forcePostProcessing,
        "queueID": queueId,
        "gameMode": gameMode,
        "isRanked": isRanked,
        "canProgressContracts": canProgressContracts,
        "isMatchSampled": isMatchSampled,
        "seasonId": seasonId,
        "completionState": completionState,
        "platformType": platformType,
      };
}

class Player {
  Player({
    this.subject,
    this.gameName,
    this.tagLine,
    this.platformInfo,
    this.teamId,
    this.partyId,
    this.characterId,
    this.stats,
    this.roundDamage = const [],
    this.competitiveTier = 0,
    this.playerCard,
    this.playerTitle,
    this.sessionPlaytimeMinutes = 0,
    this.newPlayerExperienceDetails,
  });

  final String? subject;
  final String? gameName;
  final String? tagLine;
  final PlatformInfo? platformInfo;
  final String? teamId;
  final String? partyId;
  final String? characterId;
  final Stats? stats;
  final List<RoundDamage> roundDamage;
  final int competitiveTier;
  final String? playerCard;
  final String? playerTitle;
  final int sessionPlaytimeMinutes;
  final NewPlayerExperienceDetails? newPlayerExperienceDetails;

  factory Player.fromJson(String str) => Player.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Player.fromMap(Map<String, dynamic> json) => Player(
        subject: json["subject"],
        gameName: json["gameName"],
        tagLine: json["tagLine"],
        platformInfo: json["platformInfo"] == null ? null : PlatformInfo.fromMap(json["platformInfo"]),
        teamId: json["teamId"],
        partyId: json["partyId"],
        characterId: json["characterId"],
        stats: json["stats"] == null ? null : Stats.fromMap(json["stats"]),
        roundDamage: json["roundDamage"] == null ? [] : List<RoundDamage>.from(json["roundDamage"].map((x) => RoundDamage.fromMap(x))),
        competitiveTier: json["competitiveTier"] ?? 0,
        playerCard: json["playerCard"],
        playerTitle: json["playerTitle"],
        sessionPlaytimeMinutes: json["sessionPlaytimeMinutes"] ?? 0,
        newPlayerExperienceDetails: json["newPlayerExperienceDetails"] == null ? null : NewPlayerExperienceDetails.fromMap(json["newPlayerExperienceDetails"]),
      );

  Map<String, dynamic> toMap() => {
        "subject": subject,
        "gameName": gameName,
        "tagLine": tagLine,
        "platformInfo": platformInfo?.toMap(),
        "teamId": teamId,
        "partyId": partyId,
        "characterId": characterId,
        "stats": stats?.toMap(),
        "roundDamage": List<dynamic>.from(roundDamage.map((x) => x.toMap())),
        "competitiveTier": competitiveTier,
        "playerCard": playerCard,
        "playerTitle": playerTitle,
        "sessionPlaytimeMinutes": sessionPlaytimeMinutes,
        "newPlayerExperienceDetails": newPlayerExperienceDetails?.toMap(),
      };
}

class NewPlayerExperienceDetails {
  NewPlayerExperienceDetails({
    this.basicMovement,
    this.basicGunSkill,
    this.adaptiveBots,
    this.ability,
    this.bombPlant,
    this.defendBombSite,
    this.settingStatus,
  });

  final BasicGunSkillClass? basicMovement;
  final BasicGunSkillClass? basicGunSkill;
  final AdaptiveBots? adaptiveBots;
  final BasicGunSkillClass? ability;
  final BasicGunSkillClass? bombPlant;
  final DefendBombSite? defendBombSite;
  final SettingStatus? settingStatus;

  factory NewPlayerExperienceDetails.fromJson(String str) => NewPlayerExperienceDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NewPlayerExperienceDetails.fromMap(Map<String, dynamic> json) => NewPlayerExperienceDetails(
        basicMovement: json["basicMovement"] == null ? null : BasicGunSkillClass.fromMap(json["basicMovement"]),
        basicGunSkill: json["basicGunSkill"] == null ? null : BasicGunSkillClass.fromMap(json["basicGunSkill"]),
        adaptiveBots: json["adaptiveBots"] == null ? null : AdaptiveBots.fromMap(json["adaptiveBots"]),
        ability: json["ability"] == null ? null : BasicGunSkillClass.fromMap(json["ability"]),
        bombPlant: json["bombPlant"] == null ? null : BasicGunSkillClass.fromMap(json["bombPlant"]),
        defendBombSite: json["defendBombSite"] == null ? null : DefendBombSite.fromMap(json["defendBombSite"]),
        settingStatus: json["settingStatus"] == null ? null : SettingStatus.fromMap(json["settingStatus"]),
      );

  Map<String, dynamic> toMap() => {
        "basicMovement": basicMovement?.toMap(),
        "basicGunSkill": basicGunSkill?.toMap(),
        "adaptiveBots": adaptiveBots?.toMap(),
        "ability": ability?.toMap(),
        "bombPlant": bombPlant?.toMap(),
        "defendBombSite": defendBombSite?.toMap(),
        "settingStatus": settingStatus?.toMap(),
      };
}

class BasicGunSkillClass {
  BasicGunSkillClass({
    this.idleTimeMillis = 0,
    this.objectiveCompleteTimeMillis = 0,
  });

  final int idleTimeMillis;
  final int objectiveCompleteTimeMillis;

  factory BasicGunSkillClass.fromJson(String str) => BasicGunSkillClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BasicGunSkillClass.fromMap(Map<String, dynamic> json) => BasicGunSkillClass(
        idleTimeMillis: json["idleTimeMillis"] ?? 0,
        objectiveCompleteTimeMillis: json["objectiveCompleteTimeMillis"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "idleTimeMillis": idleTimeMillis,
        "objectiveCompleteTimeMillis": objectiveCompleteTimeMillis,
      };
}

class AdaptiveBots {
  AdaptiveBots({
    this.idleTimeMillis = 0,
    this.objectiveCompleteTimeMillis = 0,
    this.adaptiveBotAverageDurationMillisAllAttempts = 0,
    this.adaptiveBotAverageDurationMillisFirstAttempt = 0,
    this.killDetailsFirstAttempt,
  });

  final int idleTimeMillis;
  final int objectiveCompleteTimeMillis;
  final int adaptiveBotAverageDurationMillisAllAttempts;
  final int adaptiveBotAverageDurationMillisFirstAttempt;
  final dynamic killDetailsFirstAttempt;

  factory AdaptiveBots.fromJson(String str) => AdaptiveBots.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AdaptiveBots.fromMap(Map<String, dynamic> json) => AdaptiveBots(
        idleTimeMillis: json["idleTimeMillis"] ?? 0,
        objectiveCompleteTimeMillis: json["objectiveCompleteTimeMillis"] ?? 0,
        adaptiveBotAverageDurationMillisAllAttempts: json["adaptiveBotAverageDurationMillisAllAttempts"] ?? 0,
        adaptiveBotAverageDurationMillisFirstAttempt: json["adaptiveBotAverageDurationMillisFirstAttempt"] ?? 0,
        killDetailsFirstAttempt: json["killDetailsFirstAttempt"],
      );

  Map<String, dynamic> toMap() => {
        "idleTimeMillis": idleTimeMillis,
        "objectiveCompleteTimeMillis": objectiveCompleteTimeMillis,
        "adaptiveBotAverageDurationMillisAllAttempts": adaptiveBotAverageDurationMillisAllAttempts,
        "adaptiveBotAverageDurationMillisFirstAttempt": adaptiveBotAverageDurationMillisFirstAttempt,
        "killDetailsFirstAttempt": killDetailsFirstAttempt,
      };
}

class DefendBombSite {
  DefendBombSite({
    this.idleTimeMillis = 0,
    this.objectiveCompleteTimeMillis = 0,
    this.success = false,
  });

  final int idleTimeMillis;
  final int objectiveCompleteTimeMillis;
  final bool success;

  factory DefendBombSite.fromJson(String str) => DefendBombSite.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DefendBombSite.fromMap(Map<String, dynamic> json) => DefendBombSite(
        idleTimeMillis: json["idleTimeMillis"] ?? 0,
        objectiveCompleteTimeMillis: json["objectiveCompleteTimeMillis"] ?? 0,
        success: json["success"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "idleTimeMillis": idleTimeMillis,
        "objectiveCompleteTimeMillis": objectiveCompleteTimeMillis,
        "success": success,
      };
}

class SettingStatus {
  SettingStatus({
    this.isMouseSensitivityDefault = false,
    this.isCrosshairDefault = false,
  });

  final bool isMouseSensitivityDefault;
  final bool isCrosshairDefault;

  factory SettingStatus.fromJson(String str) => SettingStatus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SettingStatus.fromMap(Map<String, dynamic> json) => SettingStatus(
        isMouseSensitivityDefault: json["isMouseSensitivityDefault"] ?? false,
        isCrosshairDefault: json["isCrosshairDefault"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "isMouseSensitivityDefault": isMouseSensitivityDefault,
        "isCrosshairDefault": isCrosshairDefault,
      };
}

class PlatformInfo {
  PlatformInfo({
    this.platformType,
    this.platformOs,
    this.platformOsVersion,
    this.platformChipset,
  });

  final String? platformType;
  final String? platformOs;
  final String? platformOsVersion;
  final String? platformChipset;

  factory PlatformInfo.fromJson(String str) => PlatformInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlatformInfo.fromMap(Map<String, dynamic> json) => PlatformInfo(
        platformType: json["platformType"],
        platformOs: json["platformOS"],
        platformOsVersion: json["platformOSVersion"],
        platformChipset: json["platformChipset"],
      );

  Map<String, dynamic> toMap() => {
        "platformType": platformType,
        "platformOS": platformOs,
        "platformOSVersion": platformOsVersion,
        "platformChipset": platformChipset,
      };
}

class RoundDamage {
  RoundDamage({
    this.round = 0,
    this.receiver,
    this.damage = 0,
  });

  final int round;
  final String? receiver;
  final int damage;

  factory RoundDamage.fromJson(String str) => RoundDamage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoundDamage.fromMap(Map<String, dynamic> json) => RoundDamage(
        round: json["round"] ?? 0,
        receiver: json["receiver"],
        damage: json["damage"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "round": round,
        "receiver": receiver,
        "damage": damage,
      };
}

class Stats {
  Stats({
    this.score = 0,
    this.roundsPlayed = 0,
    this.kills = 0,
    this.deaths = 0,
    this.assists = 0,
    this.playtimeMillis = 0,
    this.abilityCasts,
  });

  final int score;
  final int roundsPlayed;
  final int kills;
  final int deaths;
  final int assists;
  final int playtimeMillis;
  final AbilityCasts? abilityCasts;

  factory Stats.fromJson(String str) => Stats.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stats.fromMap(Map<String, dynamic> json) => Stats(
        score: json["score"] ?? 0,
        roundsPlayed: json["roundsPlayed"] ?? 0,
        kills: json["kills"] ?? 0,
        deaths: json["deaths"] ?? 0,
        assists: json["assists"] ?? 0,
        playtimeMillis: json["playtimeMillis"] ?? 0,
        abilityCasts: json["abilityCasts"] == null ? null : AbilityCasts.fromMap(json["abilityCasts"]),
      );

  Map<String, dynamic> toMap() => {
        "score": score,
        "roundsPlayed": roundsPlayed,
        "kills": kills,
        "deaths": deaths,
        "assists": assists,
        "playtimeMillis": playtimeMillis,
        "abilityCasts": abilityCasts?.toMap(),
      };
}

class AbilityCasts {
  AbilityCasts({
    this.grenadeCasts = 0,
    this.ability1Casts = 0,
    this.ability2Casts = 0,
    this.ultimateCasts = 0,
  });

  final int grenadeCasts;
  final int ability1Casts;
  final int ability2Casts;
  final int ultimateCasts;

  factory AbilityCasts.fromJson(String str) => AbilityCasts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AbilityCasts.fromMap(Map<String, dynamic> json) => AbilityCasts(
        grenadeCasts: json["grenadeCasts"] ?? 0,
        ability1Casts: json["ability1Casts"] ?? 0,
        ability2Casts: json["ability2Casts"] ?? 0,
        ultimateCasts: json["ultimateCasts"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "grenadeCasts": grenadeCasts,
        "ability1Casts": ability1Casts,
        "ability2Casts": ability2Casts,
        "ultimateCasts": ultimateCasts,
      };
}

class RoundResultElement {
  RoundResultElement({
    this.roundNum = 0,
    this.roundResult,
    this.roundCeremony,
    this.winningTeam,
    this.plantRoundTime = 0,
    this.plantPlayerLocations = const [],
    this.plantLocation,
    this.plantSite,
    this.defuseRoundTime = 0,
    this.defusePlayerLocations = const [],
    this.defuseLocation,
    this.playerStats = const [],
    this.roundResultCode,
    this.playerEconomies = const [],
    this.playerScores = const [],
    this.bombPlanter,
    this.bombDefuser,
  });

  final int roundNum;
  final String? roundResult;
  final String? roundCeremony;
  final String? winningTeam;
  final int plantRoundTime;
  final List<PlayerLocation> plantPlayerLocations;
  final Location? plantLocation;
  final String? plantSite;
  final int defuseRoundTime;
  final List<PlayerLocation> defusePlayerLocations;
  final Location? defuseLocation;
  final List<PlayerStat> playerStats;
  final String? roundResultCode;
  final List<Economy> playerEconomies;
  final List<PlayerScore> playerScores;
  final String? bombPlanter;
  final String? bombDefuser;

  factory RoundResultElement.fromJson(String str) => RoundResultElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RoundResultElement.fromMap(Map<String, dynamic> json) => RoundResultElement(
        roundNum: json["roundNum"] ?? 0,
        roundResult: json["roundResult"],
        roundCeremony: json["roundCeremony"],
        winningTeam: json["winningTeam"],
        plantRoundTime: json["plantRoundTime"] ?? 0,
        plantPlayerLocations:
            json["plantPlayerLocations"] == null ? [] : List<PlayerLocation>.from(json["plantPlayerLocations"].map((x) => PlayerLocation.fromMap(x))),
        plantLocation: json["plantLocation"] == null ? null : Location.fromMap(json["plantLocation"]),
        plantSite: json["plantSite"],
        defuseRoundTime: json["defuseRoundTime"] ?? 0,
        defusePlayerLocations:
            json["defusePlayerLocations"] == null ? [] : List<PlayerLocation>.from(json["defusePlayerLocations"].map((x) => PlayerLocation.fromMap(x))),
        defuseLocation: json["defuseLocation"] == null ? null : Location.fromMap(json["defuseLocation"]),
        playerStats: json["playerStats"] == null ? [] : List<PlayerStat>.from(json["playerStats"].map((x) => PlayerStat.fromMap(x))),
        roundResultCode: json["roundResultCode"],
        playerEconomies: json["playerEconomies"] == null ? [] : List<Economy>.from(json["playerEconomies"].map((x) => Economy.fromMap(x))),
        playerScores: json["playerScores"] == null ? [] : List<PlayerScore>.from(json["playerScores"].map((x) => PlayerScore.fromMap(x))),
        bombPlanter: json["bombPlanter"],
        bombDefuser: json["bombDefuser"],
      );

  Map<String, dynamic> toMap() => {
        "roundNum": roundNum,
        "roundResult": roundResult,
        "roundCeremony": roundCeremony,
        "winningTeam": winningTeam,
        "plantRoundTime": plantRoundTime,
        "plantPlayerLocations": List<dynamic>.from(plantPlayerLocations.map((x) => x.toMap())),
        "plantLocation": plantLocation?.toMap(),
        "plantSite": plantSite,
        "defuseRoundTime": defuseRoundTime,
        "defusePlayerLocations": List<dynamic>.from(defusePlayerLocations.map((x) => x.toMap())),
        "defuseLocation": defuseLocation?.toMap(),
        "playerStats": List<dynamic>.from(playerStats.map((x) => x.toMap())),
        "roundResultCode": roundResultCode,
        "playerEconomies": List<dynamic>.from(playerEconomies.map((x) => x.toMap())),
        "playerScores": List<dynamic>.from(playerScores.map((x) => x.toMap())),
        "bombPlanter": bombPlanter,
        "bombDefuser": bombDefuser,
      };
}

class Economy {
  Economy({
    this.subject,
    this.loadoutValue = 0,
    this.weapon,
    this.armor,
    this.remaining = 0,
    this.spent = 0,
  });

  final String? subject;
  final int loadoutValue;
  final String? weapon;
  final String? armor;
  final int remaining;
  final int spent;

  factory Economy.fromJson(String str) => Economy.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Economy.fromMap(Map<String, dynamic> json) => Economy(
        subject: json["subject"],
        loadoutValue: json["loadoutValue"],
        weapon: json["weapon"],
        armor: json["armor"],
        remaining: json["remaining"],
        spent: json["spent"],
      );

  Map<String, dynamic> toMap() => {
        "subject": subject,
        "loadoutValue": loadoutValue,
        "weapon": weapon,
        "armor": armor,
        "remaining": remaining,
        "spent": spent,
      };
}

class PlayerScore {
  PlayerScore({
    this.subject,
    this.score = 0,
  });

  final String? subject;
  final int score;

  factory PlayerScore.fromJson(String str) => PlayerScore.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayerScore.fromMap(Map<String, dynamic> json) => PlayerScore(
        subject: json["subject"],
        score: json["score"],
      );

  Map<String, dynamic> toMap() => {
        "subject": subject,
        "score": score,
      };
}

class PlayerStat {
  PlayerStat({
    this.subject,
    this.kills = const [],
    this.damage = const [],
    this.score = 0,
    this.economy,
    this.ability,
    this.wasAfk = false,
    this.wasPenalized = false,
    this.stayedInSpawn = false,
  });

  final String? subject;
  final List<Kill> kills;
  final List<Damage> damage;
  final int score;
  final Economy? economy;
  final PlayerStatAbility? ability;
  final bool wasAfk;
  final bool wasPenalized;
  final bool stayedInSpawn;

  factory PlayerStat.fromJson(String str) => PlayerStat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayerStat.fromMap(Map<String, dynamic> json) => PlayerStat(
        subject: json["subject"],
        kills: json["kills"] == null ? [] : List<Kill>.from(json["kills"].map((x) => Kill.fromMap(x))),
        damage: json["damage"] == null ? [] : List<Damage>.from(json["damage"].map((x) => Damage.fromMap(x))),
        score: json["score"],
        economy: json["economy"] == null ? null : Economy.fromMap(json["economy"]),
        ability: json["ability"] == null ? null : PlayerStatAbility.fromMap(json["ability"]),
        wasAfk: json["wasAfk"],
        wasPenalized: json["wasPenalized"],
        stayedInSpawn: json["stayedInSpawn"],
      );

  Map<String, dynamic> toMap() => {
        "subject": subject,
        "kills": List<dynamic>.from(kills.map((x) => x.toMap())),
        "damage": List<dynamic>.from(damage.map((x) => x.toMap())),
        "score": score,
        "economy": economy?.toMap(),
        "ability": ability?.toMap(),
        "wasAfk": wasAfk,
        "wasPenalized": wasPenalized,
        "stayedInSpawn": stayedInSpawn,
      };
}

class PlayerStatAbility {
  PlayerStatAbility({
    this.grenadeEffects,
    this.ability1Effects,
    this.ability2Effects,
    this.ultimateEffects,
  });

  final dynamic grenadeEffects;
  final dynamic ability1Effects;
  final dynamic ability2Effects;
  final dynamic ultimateEffects;

  factory PlayerStatAbility.fromJson(String str) => PlayerStatAbility.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlayerStatAbility.fromMap(Map<String, dynamic> json) => PlayerStatAbility(
        grenadeEffects: json["grenadeEffects"],
        ability1Effects: json["ability1Effects"],
        ability2Effects: json["ability2Effects"],
        ultimateEffects: json["ultimateEffects"],
      );

  Map<String, dynamic> toMap() => {
        "grenadeEffects": grenadeEffects,
        "ability1Effects": ability1Effects,
        "ability2Effects": ability2Effects,
        "ultimateEffects": ultimateEffects,
      };
}

class Damage {
  Damage({
    this.receiver,
    this.damage = 0,
    this.legshots = 0,
    this.bodyshots = 0,
    this.headshots = 0,
  });

  final String? receiver;
  final int damage;
  final int legshots;
  final int bodyshots;
  final int headshots;

  factory Damage.fromJson(String str) => Damage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Damage.fromMap(Map<String, dynamic> json) => Damage(
        receiver: json["receiver"],
        damage: json["damage"] ?? 0,
        legshots: json["legshots"] ?? 0,
        bodyshots: json["bodyshots"] ?? 0,
        headshots: json["headshots"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "receiver": receiver,
        "damage": damage,
        "legshots": legshots,
        "bodyshots": bodyshots,
        "headshots": headshots,
      };
}

class Team {
  Team({
    this.teamId,
    this.won = false,
    this.roundsPlayed = 0,
    this.roundsWon = 0,
    this.numPoints = 0,
  });

  final String? teamId;
  final bool won;
  final int roundsPlayed;
  final int roundsWon;
  final int numPoints;

  factory Team.fromJson(String str) => Team.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Team.fromMap(Map<String, dynamic> json) => Team(
        teamId: json["teamId"],
        won: json["won"],
        roundsPlayed: json["roundsPlayed"],
        roundsWon: json["roundsWon"],
        numPoints: json["numPoints"],
      );

  Map<String, dynamic> toMap() => {
        "teamId": teamId,
        "won": won,
        "roundsPlayed": roundsPlayed,
        "roundsWon": roundsWon,
        "numPoints": numPoints,
      };
}
