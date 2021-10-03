import 'dart:convert';

import 'serializable.dart';

class Id extends ISerializable<Id> {
  Id({
    this.name,
    this.id,
    this.assetName,
    this.assetPath,
    this.isEnabled = false,
    this.baseContent = false,
  });

  final String? name;
  final String? id;
  final String? assetName;
  final String? assetPath;
  final bool isEnabled;
  final bool baseContent;

  factory Id.fromJson(String str) => Id.fromMap(json.decode(str));

  @override
  Map<String, dynamic> toJson() => toMap();

  factory Id.fromMap(Map<String, dynamic> json) => Id(
        name: json["Name"],
        id: json["ID"],
        assetName: json["AssetName"],
        assetPath: json["AssetPath"],
        isEnabled: json["IsEnabled"] ?? false,
        baseContent: json["BaseContent"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "Name": name,
        "ID": id,
        "AssetName": assetName,
        "AssetPath": assetPath,
        "IsEnabled": isEnabled,
        "BaseContent": baseContent,
      };

  @override
  Id fromJson(Map<String, dynamic> json) {
    return Id.fromMap(json);
  }
}
