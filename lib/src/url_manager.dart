import 'enums.dart';

class UrlManager {
  static String get authUrl => 'https://auth.riotgames.com/api/v1/authorization';
  static String get entitlementsUrl => 'https://entitlements.auth.riotgames.com/api/token/v1';
  static String get userInfoUrl => 'https://auth.riotgames.com/userinfo';
  static String get versionUrl => 'https://valorant-api.com/v1/version';

  static String getBaseUrlForRegion(Region region) => 'https://pd.${region.humanized}.a.pvp.net';
}
