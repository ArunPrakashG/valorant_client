part of '../valorant_client_base.dart';

class AuthorizationHandler {
  final Dio _client;
  final UserDetails _userDetails;
  final Map<String, dynamic> _authHeaders = {};
  final bool shouldPersistSession;

  String _countryCode = '';
  String _tokenType = '';
  int _accessTokenExpiryInHours = 1;
  String _userPuuid = '';
  Timer? _validityTimer;
  Map<String, dynamic> _decodedAccessToken = {};

  bool get _isLoggedIn => !isNullOrEmpty(_userPuuid);

  AuthorizationHandler(
      this._client, this._userDetails, this.shouldPersistSession);

  Future<bool> authenticate(bool handleSessionAutomatically) async {
    _countryCode = '';
    _tokenType = '';
    _authHeaders.clear();
    _userPuuid = '';
    _validityTimer?.cancel();

    if (await _fetchClientCountry() &&
        await _fetchAccessToken() &&
        await _fetchEntitlements() &&
        await _fetchClientVersion() &&
        await _fetchUserInfo()) {
      _authHeaders[ClientConstants.clientPlatformHeaderKey] =
          ClientConstants.clientPlatformHeaderValue;
      _client.options.headers.addAll(_authHeaders);

      if (handleSessionAutomatically) {
        _validityTimer = Timer(Duration(hours: _accessTokenExpiryInHours),
            () async => authenticate(handleSessionAutomatically));
      }

      return true;
    }

    return false;
  }

  // TODO: Persist previous session cookies, use that cookies to authenticate again instead of using username and password.
  Future<bool> _hasSavedSession(CookieJar jar) async {
    if (!shouldPersistSession) {
      return false;
    }

    final cookies =
        await jar.loadForRequest(Uri.parse('https://auth.riotgames.com/'));

    for (var c in cookies) {
      print(c.toString());
    }

    return false;
  }

  Future<bool> _fetchClientCountry() async {
    final payload = jsonEncode(
      {
        'client_id': 'play-valorant-web-prod',
        'nonce': 1,
        'redirect_uri': 'https://playvalorant.com/opt_in',
        'response_type': 'token id_token',
      },
    );

    final response = await _client.post(
      UrlManager.authUrl,
      data: payload,
    );

    if (response.statusCode != 200) {
      return false;
    }

    _countryCode = response.data['country'] ?? '';
    return _countryCode.isNotEmpty;
  }

  Future<bool> _fetchAccessToken() async {
    if (!_userDetails.isValid) {
      return false;
    }

    final payload = jsonEncode(
      {
        'type': 'auth',
        'username': _userDetails.userName,
        'password': _userDetails.password,
      },
    );

    final response = await _client.put(
      UrlManager.authUrl,
      data: payload,
    );

    if (response.statusCode != 200) {
      return false;
    }

    if (response.data['error'] != null &&
        response.data['error'] == 'auth_failure') {
      return false;
    }

    final authUrl =
        (response.data['response']?['parameters']?['uri'] ?? '') as String;
    final parsedUri = Uri.tryParse(authUrl.replaceFirst('#', '?'));

    if (parsedUri == null || !parsedUri.hasQuery) {
      return false;
    }

    _accessTokenExpiryInHours =
        (int.tryParse(parsedUri.queryParameters['expires_in'] ?? '1') ?? 1) ~/
            3600;
    _tokenType = parsedUri.queryParameters['token_type'] as String;
    _decodedAccessToken =
        _decodeAccessToken(parsedUri.queryParameters['access_token'] as String);
    _authHeaders[HttpHeaders.authorizationHeader] =
        '$_tokenType ${parsedUri.queryParameters['access_token'] as String}';
    return parsedUri.queryParameters['access_token'] != null;
  }

  Future<bool> _fetchEntitlements() async {
    final response = await _client.post(
      UrlManager.entitlementsUrl,
      data: {},
      options: Options(headers: _authHeaders),
    );

    if (response.statusCode != 200) {
      return false;
    }

    _authHeaders['X-Riot-Entitlements-JWT'] =
        response.data['entitlements_token'] as String;
    return response.data['entitlements_token'] != null;
  }

  Future<bool> _fetchUserInfo() async {
    final response = await _client.post(
      UrlManager.userInfoUrl,
      data: {},
      options: Options(headers: _authHeaders),
    );

    if (response.statusCode != 200) {
      return false;
    }

    _userPuuid = response.data['sub'];
    return !isNullOrEmpty(_userPuuid);
  }

  Future<bool> _fetchClientVersion() async {
    final response = await _client.get(UrlManager.versionUrl);

    if (response.statusCode != 200) {
      return false;
    }

    _authHeaders['X-Riot-ClientVersion'] =
        response.data['data']['riotClientVersion'] as String;
    return response.data['data']['riotClientVersion'] != null;
  }

  @Deprecated('Removed to not use another library.')
  Map<String, dynamic> _decodeAccessToken(String token) {
    try {
      return {}; //JwtDecoder.decode(token);
    } catch (e) {
      return {};
    }
  }
}
