import 'dart:convert';

import 'serializable.dart';

class User implements ISerializable<User> {
  final String displayName;
  final String subject;
  final String gameName;
  final String tagLine;

  User({
    this.displayName = '',
    this.subject = '',
    this.gameName = '',
    this.tagLine = '',
  });

  @override
  User fromJson(Map<String, dynamic> json) {
    return User.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson() => {
        'DisplayName': displayName,
        'Subject': subject,
        'GameName': gameName,
        'TagLine': tagLine,
      };

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      displayName: map['DisplayName'],
      subject: map['Subject'],
      gameName: map['GameName'],
      tagLine: map['TagLine'],
    );
  }

  String toJsonString() => json.encode(toJson());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
