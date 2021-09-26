enum Region {
  na,
  eu,
  ap,
  ko,
}

extension EnumExtensions on Enum {
  String get humanized => toString().split('.').last;
}
