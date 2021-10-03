import '../enums.dart';
import '../models/id_collection.dart';
import '../url_manager.dart';
import '../valorant_client_base.dart';

class IdEndpoint {
  final ValorantClient _client;

  IdEndpoint(this._client);

  Future<IdCollection?> getRiotContentIds() async {
    final requestUri = Uri.parse('${UrlManager.getBaseUrlForRegion(_client.userRegion)}/content-service/v2/content');
    final response = await _client.executeRawRequest(
      method: HttpMethod.get,
      uri: requestUri,
      body: '["${_client.userPuuid}"]',
    );

    if (response == null) {
      return null;
    }

    return response != null ? IdCollection.fromMap(response) : null;
  }
}
