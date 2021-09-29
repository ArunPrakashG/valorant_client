import 'enums.dart';

class UserDetails {
  final String userName;
  final String password;
  final Region region;

  UserDetails({
    required this.userName,
    required this.password,
    required this.region,
  });

  bool get isValid => userName.isNotEmpty && password.isNotEmpty;
}
