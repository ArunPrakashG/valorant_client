part of '../valorant_client_base.dart';

class RSOHandler {
  final Dio _client;
  final UserDetails userDetails;
  String _countryCode = '';
  String _tokenType = '';
  final Map<String, dynamic> _authHeaders = {};
  int _accessTokenExpiryInHours = 1;
  String _userPuuid = '';

  bool get _isLoggedIn => !isNullOrEmpty(_userPuuid);

  RSOHandler(this._client, this.userDetails);

  Future<bool> initRSO() async {
    if (await _fetchClientCountry() && await _fetchAccessToken() && await _fetchEntitlements() && await _fetchClientVersion() && await _fetchUserInfo()) {
      _authHeaders['X-Riot-ClientPlatform'] =
          'ew0KCSJwbGF0Zm9ybVR5cGUiOiAiUEMiLA0KCSJwbGF0Zm9ybU9TIjogIldpbmRvd3MiLA0KCSJwbGF0Zm9ybU9TVmVyc2lvbiI6ICIxMC4wLjE5MDQyLjEuMjU2LjY0Yml0IiwNCgkicGxhdGZvcm1DaGlwc2V0IjogIlVua25vd24iDQp9';
      _client.options.headers.addAll(_authHeaders);
      return true;
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
    if (!userDetails.isValid) {
      return false;
    }

    final payload = jsonEncode(
      {
        'type': 'auth',
        'username': userDetails.userName,
        'password': userDetails.password,
      },
    );

    final response = await _client.put(
      UrlManager.authUrl,
      data: payload,
    );

    if (response.statusCode != 200) {
      return false;
    }

    if (response.data['error'] != null && response.data['error'] == 'auth_failure') {
      return false;
    }

    final authUrl = (response.data['response']?['parameters']?['uri'] ?? '') as String;
    final parsedUri = Uri.tryParse(authUrl.replaceFirst('#', '?'));

    if (parsedUri == null || !parsedUri.hasQuery) {
      return false;
    }

    _accessTokenExpiryInHours = (int.tryParse(parsedUri.queryParameters['expires_in'] ?? '1') ?? 1) ~/ 3600;
    _tokenType = parsedUri.queryParameters['token_type'] as String;
    _authHeaders[HttpHeaders.authorizationHeader] = '$_tokenType ${parsedUri.queryParameters['access_token'] as String}';
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

    _authHeaders['X-Riot-Entitlements-JWT'] = response.data['entitlements_token'] as String;
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

    _authHeaders['X-Riot-ClientVersion'] = response.data['data']['riotClientVersion'] as String;
    return response.data['data']['riotClientVersion'] != null;
  }
}
