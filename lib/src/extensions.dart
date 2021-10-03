import 'helpers.dart';
import 'models/asset_id.dart';
import 'models/id_collection.dart';

extension IdCollectionExtension on IdCollection {
  Id getCharacterById(String id) => characters.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getMapById(String id) => maps.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getChromaById(String id) => chromas.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getSkinById(String id) => skins.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getSkinLevelById(String id) => skinLevels.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getAttachmentById(String id) => attachments.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getEquipById(String id) => equips.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getThemeById(String id) => themes.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getGameModeById(String id) => gameModes.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getSprayById(String id) => sprays.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getSprayLevelById(String id) => sprayLevels.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getCharmById(String id) => charms.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getCharmLevelById(String id) => charmLevels.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getPlayerCardById(String id) => playerCards.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getPlayerTitleById(String id) => playerTitles.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
  Id getStorefrontItemById(String id) => storefrontItems.singleWhere((element) => !isNullOrEmpty(element.id) && element.id! == id);
}
