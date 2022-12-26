class User {
  final int id;
  final String password;
  final String fullName;
  final String email;
  final String photoUrl;
  final int studentNumber;

  User(
      {required this.id,
      required this.password,
      required this.fullName,
      required this.email,
      required this.photoUrl,
      required this.studentNumber});
}
