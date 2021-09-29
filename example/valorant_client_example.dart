import 'dart:convert';
import 'dart:io';

import 'package:valorant_client/src/enums.dart';
import 'package:valorant_client/src/user_details.dart';
import 'package:valorant_client/valorant_client.dart';

void main() async {
  var json = jsonDecode(await File('assets/test.json').readAsString());

  ValorantClient client = ValorantClient(UserDetails(userName: json['username'], password: json['password'], region: Region.ap));
  await client.init();
  var balance = await client.playerEndpoint.getBalance();
  print('${balance?.radianitePoints} radiante points');
}
