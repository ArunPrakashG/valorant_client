import 'dart:convert';

import 'serializable.dart';

class Event extends ISerializable<Event> {
  Event({
    this.id,
    this.name,
    this.type,
    this.startTime,
    this.endTime,
    this.isEnabled = false,
    this.isActive = false,
    this.developmentOnly = false,
  });

  final String? id;
  final String? name;
  final String? type;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool isEnabled;
  final bool isActive;
  final bool developmentOnly;

  Map<String, dynamic> toMap() {
    return {
      'ID': id,
      'Name': name,
      'Type': type,
      'StartTime': startTime?.toIso8601String(),
      'EndTime': endTime?.toIso8601String(),
      'IsEnabled': isEnabled,
      'IsActive': isActive,
      'DevelopmentOnly': developmentOnly,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['ID'],
      name: map['Name'],
      type: map['Type'],
      startTime: map['StartTime'] != null ? DateTime.parse(map['StartTime'] as String) : null,
      endTime: map['StartTime'] != null ? DateTime.parse(map['EndTime'] as String) : null,
      isEnabled: map['IsEnabled'],
      isActive: map['IsActive'],
      developmentOnly: map['DevelopmentOnly'],
    );
  }

  @override
  Map<String, dynamic> toJson() => toMap();

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));

  @override
  Event fromJson(Map<String, dynamic> json) => Event.fromMap(json);
}
