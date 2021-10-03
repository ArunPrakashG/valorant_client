import 'enums.dart';

class UrlManager {
  static const String authUrl = 'https://auth.riotgames.com/api/v1/authorization';
  static const String entitlementsUrl = 'https://entitlements.auth.riotgames.com/api/token/v1';
  static const String userInfoUrl = 'https://auth.riotgames.com/userinfo';
  static const String versionUrl = 'https://valorant-api.com/v1/version';

  static String getBaseUrlForRegion(Region region) => 'https://pd.${region.humanized}.a.pvp.net';

  static String getContentBaseUrlForRegion(Region region) => 'https://shared.${region.humanized}.a.pvp.net';
}
