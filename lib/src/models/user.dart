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
        'displayName': displayName,
        'subject': subject,
        'gameName': gameName,
        'tagLine': tagLine,
      };

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      displayName: map['displayName'],
      subject: map['subject'],
      gameName: map['gameName'],
      tagLine: map['tagLine'],
    );
  }

  String toJsonString() => json.encode(toJson());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
