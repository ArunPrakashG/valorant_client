import 'package:valorant_client/src/models/match.dart';

import '../../valorant_client.dart';
import '../url_manager.dart';
import '../valorant_client_base.dart';

class MatchInterface {
  final ValorantClient _client;

  MatchInterface(this._client);

  Future<Match?> getMatch(String matchPuuid) async {
    final requestUri = Uri.parse(UrlManager.getMatchInfoBaseUrlForRegion(_client.userRegion, matchPuuid));

    return _client.executeGenericRequest<Match>(
      typeResolver: Match(),
      method: HttpMethod.get,
      uri: requestUri,
    );
  }
}
