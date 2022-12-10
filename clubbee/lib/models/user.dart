class User {
  final int id;
  final String username;
  final String fullName;
  final String email;
  final String photoUrl;
  final int studentNumber;

  User(
      {required this.id,
      required this.username,
      required this.fullName,
      required this.email,
      required this.photoUrl,
      required this.studentNumber});
}
