import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:valorant_client/src/url_manager.dart';

class AuthenticationHandler {
  final Dio _client;
  final String userName;
  final String password;

  String? _accessToken;
  String? _entitlementToken;

  Map<String, dynamic>? _authHeaders;

  AuthenticationHandler(this._client, this.userName, this.password);

  Future<void> authorize() async {
    await _client.post(UrlManager.authUrl, data: {
      'client_id': 'play-valorant-web-prod',
      'nonce': '1',
      'redirect_uri': 'https://playvalorant.com/opt_in',
      'response_type': 'token id_token',
    });

    final putResponse = await _client.put(UrlManager.authUrl, data: {
      'type': 'auth',
      'username': userName,
      'password': password,
    });

    if (putResponse.statusCode != 200) {
      return;
    }

    final jsonString = jsonEncode(putResponse.data);
    if (jsonString.contains('auth_failure')) {
      return;
    }

    final authUrl = putResponse.data['response']['parameters']['uri'];
    _accessToken = RegExp('access_token=(.+?)&scope=').allMatches(authUrl).first.group(0);
  }

  Future<void> getEntitlements() async {
    _authHeaders = <String, dynamic>{
      HttpHeaders.authorizationHeader: 'Bearer $_accessToken',
    };

    final response = await _client.post(
      UrlManager.entitlementsUrl,
      data: {},
      options: Options(headers: _authHeaders),
    );

    if (response.statusCode != 200) {
      return;
    }

    _entitlementToken = response.data['entitlements_token'];
    _authHeaders!['X-Riot-Entitlements-JWT'] = _entitlementToken;
  }

  Future<void> fetchUserInfo() async {
    final response = await _client.post(
      UrlManager.userInfoUrl,
      data: {},
      options: Options(headers: _authHeaders),
    );

    print('User id: ${response.data['sub']}');
  }
}
