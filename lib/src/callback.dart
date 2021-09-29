import 'package:dio/dio.dart';
import 'package:valorant_client/src/helpers.dart';

class Callback {
  final void Function(DioError e)? onRequestError;
  final void Function(String e)? onError;

  const Callback({this.onError, this.onRequestError});

  void invokeRequestErrorCallback(DioError e) {
    if (onRequestError == null) {
      return;
    }

    return onRequestError!(e);
  }

  void invokeErrorCallback(String? e) {
    if (onError == null || isNullOrEmpty(e)) {
      return;
    }

    return onError!(e!);
  }
}
