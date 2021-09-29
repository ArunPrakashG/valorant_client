enum Region {
  na,
  eu,
  ap,
  ko,
}

enum HttpMethod {
  post,
  get,
  put,
  delete,
}

enum CurrencyType {
  valorantPoints,
  radianitePoints,
  unknown,
}

extension EnumExtensions on Enum {
  String get humanized => toString().split('.').last;
}
