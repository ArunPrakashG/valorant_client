import 'enums.dart';

class CurrencyConstants {
  static const String valorantPointsId = '85ad13f7-3d1b-5128-9eb2-7cd8ee0b5741';
  static const String radianitePointsId = 'e59aa87c-4cbf-517a-5983-6e81511be9b7';
  static const String unknownCurrency = 'f08d4ae3-939c-4576-ab26-09ce1f23bb37';

  static CurrencyType getCurrencyTypeFromId(final String id) {
    switch (id) {
      case valorantPointsId:
        return CurrencyType.valorantPoints;
      case radianitePointsId:
        return CurrencyType.radianitePoints;
      case unknownCurrency:
        return CurrencyType.unknown;
    }

    return CurrencyType.unknown;
  }
}

class ClientConstants {
  static const String clientPlatformHeaderValue =
      'ew0KCSJwbGF0Zm9ybVR5cGUiOiAiUEMiLA0KCSJwbGF0Zm9ybU9TIjogIldpbmRvd3MiLA0KCSJwbGF0Zm9ybU9TVmVyc2lvbiI6ICIxMC4wLjE5MDQyLjEuMjU2LjY0Yml0IiwNCgkicGxhdGZvcm1DaGlwc2V0IjogIlVua25vd24iDQp9';

  static const String clientPlatformHeaderKey = 'X-Riot-ClientPlatform';
}
