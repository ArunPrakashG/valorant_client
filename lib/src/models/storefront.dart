import 'dart:convert';

import 'serializable.dart';

class Storefront extends ISerializable<Storefront> {
  Storefront({
    this.featuredTheme,
    this.featuredBundle,
    this.skinsPanelLayout,
  });

  final FeaturedTheme? featuredTheme;
  final FeaturedBundle? featuredBundle;
  final SkinsPanelLayout? skinsPanelLayout;

  factory Storefront.fromJson(String str) => Storefront.fromMap(json.decode(str));

  @override
  Map<String, dynamic> toJson() => toMap();

  factory Storefront.fromMap(Map<String, dynamic> json) => Storefront(
        featuredTheme: json["FeaturedTheme"] == null ? null : FeaturedTheme.fromMap(json["FeaturedTheme"]),
        featuredBundle: json["FeaturedBundle"] == null ? null : FeaturedBundle.fromMap(json["FeaturedBundle"]),
        skinsPanelLayout: json["SkinsPanelLayout"] == null ? null : SkinsPanelLayout.fromMap(json["SkinsPanelLayout"]),
      );

  Map<String, dynamic> toMap() => {
        "FeaturedTheme": featuredTheme?.toMap(),
        "FeaturedBundle": featuredBundle?.toMap(),
        "SkinsPanelLayout": skinsPanelLayout?.toMap(),
      };

  @override
  Storefront fromJson(Map<String, dynamic> json) => Storefront.fromMap(json);
}

class FeaturedBundle {
  FeaturedBundle({
    this.bundle,
    this.bundleRemainingDurationInSeconds = -1,
  });

  final FeaturedTheme? bundle;
  final int bundleRemainingDurationInSeconds;

  factory FeaturedBundle.fromJson(String str) => FeaturedBundle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeaturedBundle.fromMap(Map<String, dynamic> json) => FeaturedBundle(
        bundle: json["Bundle"] == null ? null : FeaturedTheme.fromMap(json["Bundle"]),
        bundleRemainingDurationInSeconds: json["BundleRemainingDurationInSeconds"] ?? -1,
      );

  Map<String, dynamic> toMap() => {
        "Bundle": bundle?.toMap(),
        "BundleRemainingDurationInSeconds": bundleRemainingDurationInSeconds,
      };
}

class FeaturedTheme {
  FeaturedTheme({
    this.id,
    this.dataAssetId,
    this.currencyId,
    this.items = const [],
  });

  final String? id;
  final String? dataAssetId;
  final String? currencyId;
  final List<ItemElement> items;

  factory FeaturedTheme.fromJson(String str) => FeaturedTheme.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeaturedTheme.fromMap(Map<String, dynamic> json) => FeaturedTheme(
        id: json["ID"],
        dataAssetId: json["DataAssetID"],
        currencyId: json["CurrencyID"],
        items: json["Items"] == null ? [] : List<ItemElement>.from(json["Items"].map((x) => ItemElement.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "DataAssetID": dataAssetId,
        "CurrencyID": currencyId,
        "Items": List<dynamic>.from(items.map((x) => x.toMap())),
      };
}

class ItemElement {
  ItemElement({
    this.item,
    this.basePrice = -1,
    this.currencyId,
    this.discountPercent = -1,
    this.isPromoItem = false,
  });

  final ItemItem? item;
  final int basePrice;
  final String? currencyId;
  final int discountPercent;
  final bool isPromoItem;

  factory ItemElement.fromJson(String str) => ItemElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemElement.fromMap(Map<String, dynamic> json) => ItemElement(
        item: json["Item"] == null ? null : ItemItem.fromMap(json["Item"]),
        basePrice: json["BasePrice"] ?? -1,
        currencyId: json["CurrencyID"],
        discountPercent: json["DiscountPercent"] ?? -1,
        isPromoItem: json["IsPromoItem"] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "Item": item?.toMap(),
        "BasePrice": basePrice,
        "CurrencyID": currencyId,
        "DiscountPercent": discountPercent,
        "IsPromoItem": isPromoItem,
      };
}

class ItemItem {
  ItemItem({
    this.itemTypeId,
    this.itemId,
    this.amount = -1,
  });

  final String? itemTypeId;
  final String? itemId;
  final int amount;

  factory ItemItem.fromJson(String str) => ItemItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemItem.fromMap(Map<String, dynamic> json) => ItemItem(
        itemTypeId: json["ItemTypeID"],
        itemId: json["ItemID"],
        amount: json["Amount"] ?? -1,
      );

  Map<String, dynamic> toMap() => {
        "ItemTypeID": itemTypeId,
        "ItemID": itemId,
        "Amount": amount,
      };
}

class SkinsPanelLayout {
  SkinsPanelLayout({
    this.singleItemOffers = const [],
    this.singleItemOffersRemainingDurationInSeconds = -1,
  });

  final List<String> singleItemOffers;
  final int singleItemOffersRemainingDurationInSeconds;

  factory SkinsPanelLayout.fromJson(String str) => SkinsPanelLayout.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SkinsPanelLayout.fromMap(Map<String, dynamic> json) => SkinsPanelLayout(
        singleItemOffers: List<String>.from(json["SingleItemOffers"].map((x) => x)),
        singleItemOffersRemainingDurationInSeconds: json["SingleItemOffersRemainingDurationInSeconds"],
      );

  Map<String, dynamic> toMap() => {
        "SingleItemOffers": List<dynamic>.from(singleItemOffers.map((x) => x)),
        "SingleItemOffersRemainingDurationInSeconds": singleItemOffersRemainingDurationInSeconds,
      };
}
