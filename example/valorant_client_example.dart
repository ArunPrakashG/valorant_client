import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:valorant_client/src/callback.dart';
import 'package:valorant_client/src/enums.dart';
import 'package:valorant_client/src/user_details.dart';
import 'package:valorant_client/valorant_client.dart';
import 'package:valorant_client/src/extensions.dart';

void main() async {
  var json = jsonDecode(await File('assets/test.json').readAsString());

  ValorantClient client = ValorantClient(
    UserDetails(userName: json['username'], password: json['password'], region: Region.ap),
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

  //var balance = await client.playerEndpoint.getBalance();
  //print('${balance?.valorantPoints} valorant points');
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
