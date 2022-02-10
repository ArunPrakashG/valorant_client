// Below is a list of people and organizations that have contributed
// to the project.
// NichyX <https://github.com/NichyX>

import 'dart:convert';
import 'serializable.dart';

class Offers extends ISerializable<Offers> {
  Offers({
    this.offerList = const [],
  });

  final List<OfferElement> offerList;

  factory Offers.fromJson(String str) => Offers.fromMap(json.decode(str));

  @override
  Map<String, dynamic> toJson() => toMap();

  factory Offers.fromMap(Map<String, dynamic> json) => Offers(
        offerList: List<OfferElement>.from(
            json['Offers'].map((x) => OfferElement.fromMap(x)),
            growable: false),
      );

  Map<String, dynamic> toMap() =>
      {"Offers": offerList.map((x) => x.toMap()).toList()};

  @override
  Offers fromJson(Map<String, dynamic> json) => Offers.fromMap(json);
}

class OfferElement {
  OfferElement({
    this.id,
    this.isDirectPurchase,
    this.startDate,
    this.cost,
    this.rewards = const [],
  });

  final String? id;
  final bool? isDirectPurchase;
  final DateTime? startDate;
  final Cost? cost;
  final List<Reward> rewards;

  factory OfferElement.fromJson(String str) =>
      OfferElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OfferElement.fromMap(Map<String, dynamic> json) => OfferElement(
        id: json["OfferID"],
        isDirectPurchase: json["IsDirectPurchase"],
        startDate: DateTime.parse(json['StartDate']),
        cost: Cost(
            currency: "85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741",
            amount: json['Cost']['85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741']),
        rewards: json["Rewards"] == null
            ? []
            : List<Reward>.from(json["Rewards"].map((x) => Reward.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "OfferID": id,
        "IsDirectPurchase": isDirectPurchase,
        "StartDate": startDate.toString(),
        "Cost": cost?.toMap(),
        "Rewards": List<dynamic>.from(rewards.map((x) => x.toMap())),
      };
}

class Cost {
  Cost({
    this.currency,
    this.amount = 0,
  });

  final String? currency;
  final int amount;

  Map<String, dynamic> toMap() => {
        "85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741": amount,
      };
}

class Reward {
  Reward({
    this.itemTypeId,
    this.itemId,
    this.quantity = 0.0,
  });

  final String? itemTypeId;
  final String? itemId;
  final double quantity;

  factory Reward.fromJson(String str) => Reward.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Reward.fromMap(Map<String, dynamic> json) => Reward(
        itemTypeId: json["ItemTypeID"],
        itemId: json["ItemID"],
        quantity: json["Quantity"] != null
            ? json["Quantity"] is double
                ? json["Quantity"]
                : (json["Quantity"] as int).toDouble()
            : 0.0,
      );

  Map<String, dynamic> toMap() => {
        "ItemTypeID": itemTypeId,
        "ItemID": itemId,
        "Quantity": quantity,
      };
}
