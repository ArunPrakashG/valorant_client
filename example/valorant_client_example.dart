import 'dart:convert';
import 'dart:io';

import 'package:valorant_client/valorant_client.dart';

void main() async {
  var json = jsonDecode(await File('assets/test.json').readAsString());

  ValorantClient client = ValorantClient(json['username'], json['password']);
  await client.init();
}
