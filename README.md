<div align="center">
<h1>ValorantClient</h1>
  
[pub.dev](https://pub.dev/packages/valorant_client)

![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white) ![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

[![likes](https://badges.bar/valorant_client/likes)](https://pub.dev/packages/valorant_client/score) [![popularity](https://badges.bar/valorant_client/popularity)](https://pub.dev/packages/valorant_client/score) [![pub points](https://badges.bar/valorant_client/pub%20points)](https://pub.dev/packages/valorant_client/score)

**valorant_client** is a library to interact with VALORANT Game API's to fetch user specific data such as matches played, user info, store info etc.

</div>

---

## Usage

- Add `valorant_client` as a dependency on `pubspec.yaml` file on your project root. At the time of this writing, the latest package version is 1.1.0. Do check [Package Page](https://pub.dev/packages/valorant_client) to get latest version.

```dart
dependencies:
  valorant_client: ^1.1.3
```

- Import the library to your project class in which you want to use the library.

```dart
import 'package:valorant_client/valorant_client.dart';
```

- Create a new instance of `ValorantClient` class.

```dart
ValorantClient client = ValorantClient(
    UserDetails(userName: {'your_username'}, password: {'your_password'}, region: {your_region}),
    callback: Callback(
      onError: (String error) {
        print(error);
      },
      onRequestError: (DioError error) {
        print(error.message);
      },
    ),
  );
```

_NOTE: Passing the callback here is optional. However, to know if your request failed internally due to wrong status code etc, you will require the callback._

- Now you can initialize client. Optional `Boolean` parameter can be set as true if you want to handle re-authorization if session becames invalid.

```dart
await client.init(true);
```

_NOTE: This is an async function, it authorizes this client to valorant API's. without calling this, you will not get results from the api._

- Thats it! Now you can send api requests to Valorant API. To Get current authorized player, you can call:

```dart
final currentPlayer = await client.playerInterface.getPlayer();
```

## Features Implemented

- Authorization (RSO authorization flow)

  - You can use this authorization system to authorize an account, get Authorization headers required for API calls, and use it with any endpoint which is not yet implemented in this library.
  - Authorized Session normally lasts for 1 hour (Riot API limitation), you can set it to automatically re-authorize depending on the validity period if required.

- Player Endpoint

  - Get Player (IGN, Tag Line)
  - Get Store Items
  - Get MMR
  - Get Balance (VP, Radianite Points etc)

- Assets Endpoint
  - Get All Content Assets (Including their path, asset id etc)

<a href="https://www.buymeacoffee.com/arunprakashg" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>
