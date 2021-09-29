import '../constants.dart';
import '../enums.dart';
import '../models/balance.dart';
import '../models/mmr.dart';
import '../models/user.dart';
import '../url_manager.dart';
import '../valorant_client_base.dart';

class PlayerEndpoint {
  final ValorantClient _client;

  PlayerEndpoint(this._client);

  Future<User?> getPlayer() async {
    final requestUri = Uri.parse('${UrlManager.getBaseUrlForRegion(_client.userRegion)}/name-service/v2/players');
    return _client.executeGenericRequest<User>(
      method: HttpMethod.put,
      uri: requestUri,
      body: '["${_client.userPuuid}"]',
    );
  }

  Future<Balance?> getBalance() async {
    final requestUri = Uri.parse('${UrlManager.getBaseUrlForRegion(_client.userRegion)}/store/v1/wallet/${_client.userPuuid}');
    final response = await _client.executeRawRequest(
      method: HttpMethod.get,
      uri: requestUri,
    );

    if (response == null) {
      return null;
    }

    return Balance(
      valorantPoints: response[CurrencyConstants.valorantPointsId] as int,
      radianitePoints: response[CurrencyConstants.radianitePointsId] as int,
      unknowCurrency: response[CurrencyConstants.unknownCurrency] as int,
    );
  }

  Future<MMR?> getMMR() async {
    final requestUri = Uri.parse('${UrlManager.getBaseUrlForRegion(_client.userRegion)}/mmr/v1/players/${_client.userPuuid}/competitiveupdates');
    final response = await _client.executeGenericRequest<MMR>(
      method: HttpMethod.get,
      uri: requestUri,
    );

    if (response == null) {
      return null;
    }

    return response;
  }
}
