import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'authentication/rso_handler.dart';
import 'enums.dart';
import 'models/user.dart';
import 'url_manager.dart';
import 'user_details.dart';

class ValorantClient {
  late Dio _client;
  final String userName;
  final String password;

  String _playerUuid = '';

  ValorantClient(this.userName, this.password) {
    _client = Dio();
    var cookieJar = CookieJar();
    _client.interceptors.add(CookieManager(cookieJar));
  }

  Future<void> init() async {
    RSOHandler handler = RSOHandler(_client, UserDetails(userName: userName, password: password));
    final result = await handler.initRSO();

    if (result.item1) {
      print('Authentication Success! User => ${result.item2}');
      _playerUuid = result.item2;
      await getCurrentPlayer();
    }
  }

  Future<User> getCurrentPlayer() async {
    try {
      final response = await _client.put(
        Uri.parse('${UrlManager.getBaseUrlForRegion(Region.ap)}/name-service/v2/players').toString(),
        data: '["$_playerUuid"]',
        options: Options(contentType: ContentType.json.value),
      );

      if (response.statusCode != 200) {
        return null;
      }

      print(response.data);
    } on DioError catch (e) {
      print(e);
    }
  }
}
