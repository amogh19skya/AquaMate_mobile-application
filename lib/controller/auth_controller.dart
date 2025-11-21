import 'package:aqua_mate/model/user_model.dart';

class AuthController {
  final List<UserModel> users = [];

  String register({
    required String fullName,
    required String email,
    required String password,
    required String gender,
    required String dob,
  }) {
    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      return "Please fill all fields";
    }

    bool emailExists = users.any((u) => u.email == email);
    if (emailExists) {
      return "Email already registered!";
    }

    users.add(
      UserModel(
        fullName: fullName,
        email: email,
        password: password,
        gender: gender,
        dob: dob,
      ),
    );

    return "Success";
  }
}
