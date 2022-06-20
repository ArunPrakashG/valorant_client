import '../enums.dart';
import '../models/id_collection.dart';
import '../url_manager.dart';
import '../valorant_client_base.dart';

class AssetInterface {
  final ValorantClient _client;

  AssetInterface(this._client);

  Future<IdCollection?> getAssets() async {
    final requestUri = Uri.parse(
      '${UrlManager.getContentBaseUrlForRegion(_client.userRegion)}/content-service/v2/content',
    );

    final response = await _client.executeRawRequest(
      method: HttpMethod.get,
      uri: requestUri,
    );

    if (response == null) {
      return null;
    }

    return IdCollection.fromMap(response);
  }
}
