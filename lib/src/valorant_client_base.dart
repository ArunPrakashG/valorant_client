import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'callback.dart';
import 'enums.dart';
import 'helpers.dart';
import 'models/serializable.dart';
import 'url_manager.dart';
import 'user_details.dart';

part 'authentication/rso_handler.dart';

class ValorantClient {
  late Dio _client;
  late CookieJar _cookieJar;
  late RSOHandler _rsoHandler;

  final UserDetails _userDetails;
  final Callback callback;

  bool _isInitialized = false;

  String get userPuuid => _rsoHandler._userPuuid;
  Region get userRegion => _userDetails.region;

  ValorantClient(this._userDetails, {this.callback = const Callback()}) {
    _client = Dio();
    _cookieJar = CookieJar();
    _client.interceptors.add(CookieManager(_cookieJar));
    _rsoHandler = RSOHandler(_client, _userDetails);
  }

  Future<bool> init() async {
    if (_rsoHandler._isLoggedIn) {
      return true;
    }

    if (!await _rsoHandler.initRSO()) {
      callback.invokeErrorCallback('Authentication Failed.');
      return false;
    }

    return _isInitialized = true;
  }

  Future<Map<String, dynamic>?> executeRawRequest({required HttpMethod method, required Uri uri, dynamic body}) async {
    if (!_isInitialized) {
      callback.invokeErrorCallback('Client is not initialized yet. Try calling init()');
      return null;
    }

    try {
      final response = await _client.requestUri(
        uri,
        data: body,
        options: Options(contentType: ContentType.json.value, method: method.humanized.toUpperCase()),
      );

      if (response.statusCode != 200) {
        return null;
      }

      return response.data;
    } on DioError catch (e) {
      callback.invokeRequestErrorCallback(e);
      return null;
    }
  }

  Future<T?> executeGenericRequest<T extends ISerializable<T>>({required HttpMethod method, required Uri uri, dynamic body}) async {
    if (!_isInitialized) {
      callback.invokeErrorCallback('Client is not initialized yet. Try calling init()');
      return null;
    }

    try {
      final response = await _client.requestUri<T>(
        uri,
        data: body,
        options: Options(contentType: ContentType.json.value, method: method.humanized.toUpperCase()),
      );

      if (response.statusCode != 200) {
        return null;
      }

      return response.data;
    } on DioError catch (e) {
      callback.invokeRequestErrorCallback(e);
      return null;
    }
  }
}
