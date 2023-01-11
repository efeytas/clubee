class User {
  final int id;
  final String fullName;
  final String email;
  final String admin_password;
  final String studentNumber;

  User(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.admin_password,
      required this.studentNumber});
}
