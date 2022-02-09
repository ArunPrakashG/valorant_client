import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:valorant_client/valorant_client.dart';

void main() async {
  var json = jsonDecode(await File('assets/test.json').readAsString());

  ValorantClient client = ValorantClient(
    UserDetails(
      userName: json['username'],
      password: json['password'],
      region: Region.eu, // Available regions: na, eu, ap, ko
    ),
    shouldPersistSession: false,
    callback: Callback(
      onError: (String error) {
        print(error);
      },
      onRequestError: (DioError error) {
        print(error.message);
      },
    ),
  );

  await client.init(true);

  print('Player PUUID => ${client.userPuuid}');

  // TODO: To implement \lib\src\authentication\rso_handler.dart
  // for (var item in client.decodedAccessTokenFields.entries) {
  //  print('${item.key} -> ${item.value}');
  // }

  var balance = await client.playerInterface.getBalance();
  print('${balance?.valorantPoints} valorant points');
  print('${balance?.radianitePoints} radianite points');
/*
  await Future<void>.delayed(const Duration(seconds: 1));

  final assets = await client.assetInterface.getAssets();

  if (assets == null) {
    print('error with assets request');
    return;
  }

  final storefront = await client.playerInterface.getStorefront();

  if (storefront != null && storefront.skinsPanelLayout != null) {
    for (var item in storefront.skinsPanelLayout!.singleItemOffers) {
      print('${item.parseAsRiotAssetId(assets.storefrontItems)}');
    }
  }*/
}
