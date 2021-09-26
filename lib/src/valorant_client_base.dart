import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:valorant_client/src/authentication/handler.dart';

class ValorantClient {
  late Dio _client;
  final String userName;
  final String password;

  ValorantClient(this.userName, this.password) {
    _client = Dio();
    var cookieJar = CookieJar();
    _client.interceptors.add(CookieManager(cookieJar));
  }

  Future<void> init() async {
    AuthenticationHandler handler = AuthenticationHandler(_client, userName, password);
    handler.authorize();
    handler.getEntitlements();
    handler.fetchUserInfo();
  }
}
