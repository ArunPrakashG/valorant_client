import 'package:valorant_client/src/models/match.dart';
import 'package:valorant_client/src/models/match_history.dart';

import '../../valorant_client.dart';
import '../url_manager.dart';

class MatchInterface {
  final ValorantClient _client;

  MatchInterface(this._client);

  Future<Match?> getMatch(
    String matchPuuid,
  ) async {
    final requestUri = Uri.parse(
      UrlManager.getMatchInfoBaseUrlForRegion(
        _client.userRegion,
        matchPuuid,
      ),
    );

    return _client.executeGenericRequest<Match>(
      typeResolver: () => Match(),
      method: HttpMethod.get,
      uri: requestUri,
    );
  }

  Future<MatchHistory?> getHistory({
    int startIndex = 0,
    int endIndex = 10,
  }) async {
    final requestUri = Uri.parse(
      '${UrlManager.getBaseUrlForRegion(_client.userRegion)}/match-history/v1/history/${_client.userPuuid}?startIndex=$startIndex&endIndex=$endIndex',
    );

    return _client.executeGenericRequest<MatchHistory>(
      typeResolver: () => MatchHistory(),
      method: HttpMethod.get,
      uri: requestUri,
    );
  }
}
