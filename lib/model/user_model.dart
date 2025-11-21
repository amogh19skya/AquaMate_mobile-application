class UserModel {
  String fullName;
  String email;
  String password;
  String gender;
  String dob; // DD/MM/YYYY string

  UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.gender,
    required this.dob,
  });
}
