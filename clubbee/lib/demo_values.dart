class User {
  final String name;
  final String surname;
  final String email;
  final String studentID;
  final String imagePath;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.surname,
    required this.studentID,
  });
}

class DemoValues {
  static final String userName = "Shakleen Ishfar";
  static final String userEmail = "shakleenishfar@gmail.com";
  static final String postTime = "30 April, 2019";
  static final String postTitle = "Maple Trees";
  static final String postSummary =
      "A comparative study of maple leaves and other plants";
}
