import 'dart:convert';

import 'asset_id.dart';
import 'event.dart';
import 'serializable.dart';

class IdCollection extends ISerializable<IdCollection> {
  final List<Id> characters;
  final List<Id> maps;
  final List<Id> chromas;
  final List<Id> skins;
  final List<Id> skinLevels;
  final List<Id> attachments;
  final List<Id> equips;
  final List<Id> themes;
  final List<Id> gameModes;
  final List<Id> sprays;
  final List<Id> sprayLevels;
  final List<Id> charms;
  final List<Id> charmLevels;
  final List<Id> playerCards;
  final List<Id> playerTitles;
  final List<Id> storefrontItems;
  final List<Event> seasons;
  final List<Event> events;

  IdCollection({
    this.characters = const [],
    this.maps = const [],
    this.chromas = const [],
    this.skins = const [],
    this.skinLevels = const [],
    this.attachments = const [],
    this.equips = const [],
    this.themes = const [],
    this.gameModes = const [],
    this.sprays = const [],
    this.sprayLevels = const [],
    this.charms = const [],
    this.charmLevels = const [],
    this.playerCards = const [],
    this.playerTitles = const [],
    this.storefrontItems = const [],
    this.seasons = const [],
    this.events = const [],
  });

  factory IdCollection.fromJson(String source) => IdCollection.fromMap(json.decode(source));

  factory IdCollection.fromMap(Map<String, dynamic> map) {
    return IdCollection(
      characters: List<Id>.from(map['Characters'].map((x) => Id.fromMap(x)), growable: false),
      maps: List<Id>.from(map['Maps'].map((x) => Id.fromMap(x)), growable: false),
      chromas: List<Id>.from(map['Chromas'].map((x) => Id.fromMap(x)), growable: false),
      skins: List<Id>.from(map['Skins'].map((x) => Id.fromMap(x)), growable: false),
      skinLevels: List<Id>.from(map['SkinLevels'].map((x) => Id.fromMap(x)), growable: false),
      attachments: List<Id>.from(map['Attachments'].map((x) => Id.fromMap(x)), growable: false),
      equips: List<Id>.from(map['Equips'].map((x) => Id.fromMap(x)), growable: false),
      themes: List<Id>.from(map['Themes'].map((x) => Id.fromMap(x)), growable: false),
      gameModes: List<Id>.from(map['GameModes'].map((x) => Id.fromMap(x)), growable: false),
      sprays: List<Id>.from(map['Sprays'].map((x) => Id.fromMap(x)), growable: false),
      sprayLevels: List<Id>.from(map['SprayLevels'].map((x) => Id.fromMap(x)), growable: false),
      charms: List<Id>.from(map['Charms'].map((x) => Id.fromMap(x)), growable: false),
      charmLevels: List<Id>.from(map['CharmLevels'].map((x) => Id.fromMap(x)), growable: false),
      playerCards: List<Id>.from(map['PlayerCards'].map((x) => Id.fromMap(x)), growable: false),
      playerTitles: List<Id>.from(map['PlayerTitles'].map((x) => Id.fromMap(x)), growable: false),
      storefrontItems: List<Id>.from(map['StorefrontItems'].map((x) => Id.fromMap(x)), growable: false),
      seasons: List<Event>.from(map['Seasons'].map((x) => Event.fromMap(x)), growable: false),
      events: List<Event>.from(map['Events'].map((x) => Event.fromMap(x)), growable: false),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'Characters': characters.map((x) => x.toMap()).toList(),
      'Maps': maps.map((x) => x.toMap()).toList(),
      'Chromas': chromas.map((x) => x.toMap()).toList(),
      'Skins': skins.map((x) => x.toMap()).toList(),
      'SkinLevels': skinLevels.map((x) => x.toMap()).toList(),
      'Attachments': attachments.map((x) => x.toMap()).toList(),
      'Equips': equips.map((x) => x.toMap()).toList(),
      'Themes': themes.map((x) => x.toMap()).toList(),
      'GameModes': gameModes.map((x) => x.toMap()).toList(),
      'Sprays': sprays.map((x) => x.toMap()).toList(),
      'SprayLevels': sprayLevels.map((x) => x.toMap()).toList(),
      'Charms': charms.map((x) => x.toMap()).toList(),
      'CharmLevels': charmLevels.map((x) => x.toMap()).toList(),
      'PlayerCards': playerCards.map((x) => x.toMap()).toList(),
      'PlayerTitles': playerTitles.map((x) => x.toMap()).toList(),
      'StorefrontItems': storefrontItems.map((x) => x.toMap()).toList(),
      'Seasons': seasons.map((x) => x.toMap()).toList(),
      'Events': events.map((x) => x.toMap()).toList(),
    };
  }

  @override
  Map<String, dynamic> toJson() => toMap();

  @override
  IdCollection fromJson(Map<String, dynamic> json) => IdCollection.fromMap(json);
}
