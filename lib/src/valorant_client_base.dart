import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import 'callback.dart';
import 'endpoints/id_endpoint.dart';
import 'endpoints/player_endpoint.dart';
import 'enums.dart';
import 'extensions.dart';
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
  bool get isInitialized => _isInitialized;

  /// The validity period of this authenticated session.
  ///
  /// After [sessionValidityInHours] period, current authorized session will be invalid and you will need to authorize with riot api again.
  ///
  /// If you have [handleSessionAutomatically] set to True, it will be handled automatically
  int get sessionValidityInHours => _rsoHandler._accessTokenExpiryInHours;

  /// Gets the headers which helps to authorize a request to RIOT Valorant API.
  ///
  /// Use this to send custom requests with authorization.
  ///
  /// You will get Empty Map if [isInitialized] is false or authorization failed internally.
  Map<String, dynamic> get getAuthorizationHeaders => _rsoHandler._authHeaders;

  late PlayerEndpoint playerEndpoint = PlayerEndpoint(this);
  late IdEndpoint idEndpoint = IdEndpoint(this);

  ValorantClient(this._userDetails, {this.callback = const Callback()}) {
    _client = Dio();
    _cookieJar = CookieJar();
    _client.interceptors.add(CookieManager(_cookieJar));
    _rsoHandler = RSOHandler(_client, _userDetails);
  }

  /// Initializes the client by authorizing the user with the constructor supplied [UserDetails]
  ///
  /// Must be called on every instance of [ValorantClient] to send authorized requests from the instance.
  Future<bool> init(bool handleSessionAutomatically) async {
    if (_rsoHandler._isLoggedIn) {
      return true;
    }

    if (!await _rsoHandler.authenticate(handleSessionAutomatically)) {
      callback.invokeErrorCallback('Authentication Failed.');
      return false;
    }

    return _isInitialized = true;
  }

  /// Executes a raw request with authentication to the specified [Uri] with specified [HttpMethod] and with the specified body (if any)
  ///
  /// returns a [Map] of response data if the request is a success.
  Future<dynamic> executeRawRequest({required HttpMethod method, required Uri uri, dynamic body}) async {
    if (!_isInitialized) {
      callback.invokeErrorCallback('Client is not initialized yet. Try calling init()');
      return null;
    }

    try {
      Response<dynamic> response;

      if (body == null) {
        response = await _client.requestUri(
          uri,
          options: Options(
            contentType: ContentType.json.value,
            responseType: ResponseType.json,
            method: method.humanized.toUpperCase(),
          ),
        );
      } else {
        response = await _client.requestUri(
          uri,
          data: body,
          options: Options(
            contentType: ContentType.json.value,
            responseType: ResponseType.json,
            method: method.humanized.toUpperCase(),
          ),
        );
      }

      if (response.statusCode != 200) {
        return null;
      }

      return response.data is String ? jsonDecode(response.data) : response.data;
    } on DioError catch (e) {
      callback.invokeRequestErrorCallback(e);
      return null;
    }
  }

  /// Executes a generic request with authentication to the specified [Uri] with specified [HttpMethod] and with the specified body (if any)
  ///
  /// returns response data as [T] type which is specified as a generic type parameter to the function.
  Future<T?> executeGenericRequest<T extends ISerializable<T>>({required T typeResolver, required HttpMethod method, required Uri uri, dynamic body}) async {
    if (!_isInitialized) {
      callback.invokeErrorCallback('Client is not initialized yet. Try calling init()');
      return null;
    }

    try {
      Response<dynamic> response;

      if (body == null) {
        response = await _client.requestUri(
          uri,
          options: Options(
            contentType: ContentType.json.value,
            responseType: ResponseType.json,
            method: method.humanized.toUpperCase(),
          ),
        );
      } else {
        response = await _client.requestUri(
          uri,
          data: body,
          options: Options(
            contentType: ContentType.json.value,
            responseType: ResponseType.json,
            method: method.humanized.toUpperCase(),
          ),
        );
      }

      if (response.statusCode != 200) {
        return null;
      }

      return typeResolver.fromJson(response.data is String ? jsonDecode(response.data) : response.data);
    } on DioError catch (e) {
      callback.invokeRequestErrorCallback(e);
      return null;
    }
  }
}
