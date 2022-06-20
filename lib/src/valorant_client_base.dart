import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:valorant_client/src/constants.dart';
import 'package:valorant_client/src/interfaces/match.dart';

import 'callback.dart';
import 'enums.dart';
import 'extensions.dart';
import 'helpers.dart';
import 'interfaces/asset.dart';
import 'interfaces/player.dart';
import 'models/serializable.dart';
import 'url_manager.dart';
import 'user_details.dart';

part 'authentication/authorization_handler.dart';

class ValorantClient {
  late final Dio _client = Dio();
  late CookieJar _cookieJar;
  late final AuthorizationHandler _rsoHandler = AuthorizationHandler(
    _client,
    _userDetails,
    persistSession,
    authCodeCallback,
  );

  final UserDetails _userDetails;

  /// [Callback]'s are containers for functions which are called on an event such as on an error during a request process etc. They help to know what error occured and where it occured.
  ///
  /// To register a callback, simply pass [Callback] instance with required parameters to this instance constructor.
  final Callback callback;

  bool _isInitialized = false;

  /// Stores the cookies locally for reauthentication
  final bool persistSession;

  /// Uses Dio's log interceptor which prints all requests and responses to the console.
  final bool enableDebugLog;

  /// PUUID of the logged in User
  String get userPuuid => _rsoHandler._userPuuid;

  /// Region of logged in User
  Region get userRegion => _userDetails.region;

  /// Returns true only if this instance is authorized and completed its startup process
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
  Map<String, dynamic> get getAuthorizationHeaders {
    return _rsoHandler._authHeaders;
  }

  /// This interface wraps over all player specific requests.
  ///
  /// Endpoints are loaded lazily. That means, they are only initilized when they are referenced the first time of their usage.
  ///
  /// ie, If you never reference [assetInterface] in your project, it won't be loaded onto memory and as a matter of fact, memory will be saved.
  late PlayerInterface playerInterface = PlayerInterface(this);

  /// This interface wraps over all riot asset specific requests.
  ///
  /// Endpoints are loaded lazily. That means, they are only initilized when they are referenced the first time of their usage.
  ///
  /// ie, If you never reference [assetInterface] in your project, it won't be loaded onto memory and as a matter of fact, memory will be saved.
  late AssetInterface assetInterface = AssetInterface(this);

  /// This interface wraps over all match specific requests.
  ///
  /// Endpoints are loaded lazily. That means, they are only initilized when they are referenced the first time of their usage.
  ///
  /// ie, If you never reference [assetInterface] in your project, it won't be loaded onto memory and as a matter of fact, memory will be saved.
  late MatchInterface matchInterface = MatchInterface(this);

  final Future<String?> Function()? authCodeCallback;

  /// Default constructor of [ValorantClient]
  ///
  /// [_userDetails] parameter must contain a valid Username and Password else login will fail.
  ///
  /// [callback] is optional. Pass a Callback instance to this for events on request error or internal error.
  ///
  ValorantClient(
    this._userDetails, {
    this.callback = const Callback(),
    this.enableDebugLog = false,
    this.persistSession = false,
    this.authCodeCallback,
  });

  /// Initializes the client by authorizing the user with the constructor supplied [UserDetails]
  ///
  /// Must be called on every instance of [ValorantClient] to send authorized requests from the instance.
  Future<bool> init() async {
    if (_rsoHandler._isLoggedIn) {
      return true;
    }

    _cookieJar = persistSession ? PersistCookieJar() : CookieJar();
    _client.interceptors.add(CookieManager(_cookieJar));

    if (enableDebugLog) {
      _client.interceptors.add(LogInterceptor(responseBody: true));
    }

    if (!await _rsoHandler.authenticate(persistSession)) {
      callback.invokeErrorCallback('Authentication Failed.');
      return false;
    }

    return _isInitialized = true;
  }

  /// Executes a raw request with authentication to the specified [Uri] with specified [HttpMethod] and with the specified body (if any)
  ///
  /// returns a [Map] of response data if the request is a success.
  Future<dynamic> executeRawRequest({
    required HttpMethod method,
    required Uri uri,
    dynamic body,
    bool skipInit = false,
  }) async {
    if (!skipInit && !_isInitialized) {
      callback.invokeErrorCallback(
        'Client is not initialized yet. Try calling init()',
      );
      return null;
    }

    try {
      final response = await _client.requestUri(
        uri,
        data: body,
        options: Options(
          contentType: ContentType.json.value,
          responseType: ResponseType.json,
          method: method.humanized.toUpperCase(),
        ),
      );

      if (response.statusCode != 200) {
        return null;
      }

      if (response.data is String) {
        return json.decode(response.data);
      }

      return response.data;
    } on DioError catch (e) {
      callback.invokeRequestErrorCallback(e);
      return null;
    }
  }

  /// Executes a generic request with authentication to the specified [Uri] with specified [HttpMethod] and with the specified body (if any)
  ///
  /// returns response data as [T] type which is specified as a generic type parameter to the function.
  Future<T?> executeGenericRequest<T extends ISerializable<T>>({
    required T Function() typeResolver,
    required HttpMethod method,
    required Uri uri,
    dynamic body,
    bool skipInit = false,
  }) async {
    if (!skipInit && !_isInitialized) {
      callback.invokeErrorCallback(
        'Client is not initialized yet. Try calling init()',
      );
      return null;
    }

    try {
      final response = await _client.requestUri(
        uri,
        data: body,
        options: Options(
          contentType: ContentType.json.value,
          responseType: ResponseType.json,
          method: method.humanized.toUpperCase(),
        ),
      );

      if (response.statusCode != 200) {
        return null;
      }

      dynamic data = response.data;

      if (response.data is String) {
        data = json.decode(response.data);
      }

      return typeResolver().fromJson(data);
    } on DioError catch (e) {
      callback.invokeRequestErrorCallback(e);
      return null;
    }
  }
}
