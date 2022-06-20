part of '../valorant_client_base.dart';

class AuthorizationHandler {
  final Dio _client;
  final UserDetails _userDetails;
  final Map<String, dynamic> _authHeaders = {};
  final bool _persistSession;

  String _countryCode = '';
  String _tokenType = '';
  int _accessTokenExpiryInHours = 1;
  String _userPuuid = '';
  Timer? _validityTimer;
  bool _has2FA = false;

  final Future<String?> Function()? _getAccessTokenCallback;

  bool get _isLoggedIn => !isNullOrEmpty(_userPuuid);

  AuthorizationHandler(
    this._client,
    this._userDetails,
    this._persistSession,
    this._getAccessTokenCallback,
  );

  Future<bool> authenticate(bool handleSessionAutomatically) async {
    _countryCode = '';
    _tokenType = '';
    _authHeaders.clear();
    _userPuuid = '';
    _validityTimer?.cancel();

    final clientCountryResult = await _fetchClientCountry();
    log('clientCountryResult: $clientCountryResult');

    if (!clientCountryResult) {
      return false;
    }

    final accessTokenResult = await _fetchAccessToken();
    log('accessTokenResult: $accessTokenResult');

    if (!accessTokenResult) {
      return false;
    }

    final entitlementsResult = await _fetchEntitlements();
    log('entitlementsResult: $entitlementsResult');

    if (!entitlementsResult) {
      return false;
    }

    final clientVersionResult = await _fetchClientVersion();
    log('clientVersionResult: $clientVersionResult');

    if (!clientVersionResult) {
      return false;
    }

    final userInfoResult = await _fetchUserInfo();
    log('userInfoResult: $userInfoResult');

    if (!userInfoResult) {
      return false;
    }

    final isSuccess = clientCountryResult &&
        accessTokenResult &&
        entitlementsResult &&
        clientVersionResult &&
        userInfoResult;

    if (!isSuccess) {
      return false;
    }

    _authHeaders[ClientConstants.clientPlatformHeaderKey] =
        ClientConstants.clientPlatformHeaderValue;
    _client.options.headers.addAll(_authHeaders);

    if (handleSessionAutomatically) {
      _validityTimer = Timer(
        Duration(hours: _accessTokenExpiryInHours),
        () async => authenticate(
          handleSessionAutomatically,
        ),
      );
    }

    return true;
  }

  // TODO: Persist previous session cookies, use that cookies to authenticate again instead of using username and password.
  Future<bool> _hasSavedSession(CookieJar jar) async {
    if (!_persistSession) {
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

    final code = response.data?['country'] as String?;

    if (code == null) {
      return false;
    }

    _countryCode = code;

    return true;
  }

  Future<bool> _fetchAccessToken({
    String? authCode,
    bool is2Fa = false,
  }) async {
    if (!_userDetails.isValid) {
      return false;
    }

    final payload = jsonEncode(
      {
        'type': is2Fa ? 'multifactor' : 'auth',
        if (is2Fa) 'code': authCode,
        if (!is2Fa) 'username': _userDetails.userName,
        if (!is2Fa) 'password': _userDetails.password,
        'rememberDevice': true,
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

    _has2FA = !is2Fa && response.data?['type'] == 'multifactor';

    if (_has2FA) {
      if (_getAccessTokenCallback == null) {
        return false;
      }

      String? authCode = await _getAccessTokenCallback!();

      return await _fetchAccessToken(authCode: authCode, is2Fa: _has2FA);
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
}
