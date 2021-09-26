class UserDetails {
  final String userName;
  final String password;

  UserDetails({
    required this.userName,
    required this.password,
  });

  bool get isValid => userName.isNotEmpty && password.isNotEmpty;
}
