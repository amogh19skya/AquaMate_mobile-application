import 'package:flutter/material.dart';

// Assuming 'package:aqua_mate/main.dart' provides authController
import 'package:aqua_mate/main.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // TEXT CONTROLLERS
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  String? _selectedGender;

  // ERROR VARIABLES
  String? fullNameError;
  String? emailError;
  String? passwordError;
  String? genderError;
  String? dobError;

  // VALIDATION + REGISTER
  _onSignup() {
    setState(() {
      fullNameError = null;
      emailError = null;
      passwordError = null;
      genderError = null;
      dobError = null;
    });

    bool isValid = true;

    // FULL NAME
    if (_fullNameController.text.trim().isEmpty) {
      fullNameError = "Full name is required";
      isValid = false;
    }

    // EMAIL
    if (_emailController.text.trim().isEmpty) {
      emailError = "Email is required";
      isValid = false;
    } else {
      bool emailValid = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
          .hasMatch(_emailController.text.trim());

      if (!emailValid) {
        emailError = "Enter a valid email";
        isValid = false;
      }
    }

    // PASSWORD
    if (_passwordController.text.trim().isEmpty) {
      passwordError = "Password is required";
      isValid = false;
    } else if (_passwordController.text.trim().length < 6) {
      passwordError = "Password must be at least 6 characters";
      isValid = false;
    }

    // GENDER
    if (_selectedGender == null) {
      genderError = "Please select a gender";
      isValid = false;
    }

    // DOB
    if (_dateOfBirthController.text.trim().isEmpty) {
      dobError = "Date of birth is required";
      isValid = false;
    }

    setState(() {});

    // STOP IF INVALID
    if (!isValid) return;

    // API CALL
    String result = authController.register(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      gender: _selectedGender!,
      dob: _dateOfBirthController.text.trim(),
    );

    if (result == "Success") {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result)),
      );
    }
  }

  // DATE PICKER
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateOfBirthController.text =
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  // CUSTOM INPUT FIELD
  Widget _buildCustomInputField({
    required TextEditingController controller,
    required String labelText,
    IconData? suffixIcon,
    bool isPassword = false,
    bool readOnly = false,
    VoidCallback? onTap,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF454545)),
        ),
        const SizedBox(height: 6),

        Container(
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (errorText != null) ? Colors.red : Color(0xFFCCCCCC),
              width: 0.7,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            readOnly: readOnly,
            onTap: onTap,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              border: InputBorder.none,
              suffixIcon: suffixIcon != null
                  ? Icon(suffixIcon, color: Colors.grey)
                  : null,
            ),
          ),
        ),

        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF26A69A), Color(0xFF80DEEA)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Icon(Icons.anchor, size: 80, color: Colors.white),
                    ),
                  ),
                ),

                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                Positioned(
                  bottom: -30,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: const [
                      Text("New Account",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF454545))),
                      SizedBox(height: 5),
                      Text("Register to continue the\nAquaMate",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),

            // FORM
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildCustomInputField(
                      controller: _fullNameController,
                      labelText: "Full Name",
                      errorText: fullNameError),
                  const SizedBox(height: 20),

                  _buildCustomInputField(
                      controller: _emailController,
                      labelText: "Email",
                      suffixIcon: Icons.mail_outline,
                      errorText: emailError),
                  const SizedBox(height: 20),

                  _buildCustomInputField(
                      controller: _passwordController,
                      labelText: "Password",
                      isPassword: true,
                      suffixIcon: Icons.vpn_key_outlined,
                      errorText: passwordError),
                  const SizedBox(height: 20),

                  // GENDER
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Gender",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF454545))),
                      Row(
                        children: [
                          Row(children: [
                            Radio<String>(
                              value: "Male",
                              groupValue: _selectedGender,
                              onChanged: (value) => setState(() {
                                _selectedGender = value;
                              }),
                            ),
                            const Text("Male"),
                          ]),
                          Row(children: [
                            Radio<String>(
                              value: "Female",
                              groupValue: _selectedGender,
                              onChanged: (value) => setState(() {
                                _selectedGender = value;
                              }),
                            ),
                            const Text("Female"),
                          ]),
                          Row(children: [
                            Radio<String>(
                              value: "Others",
                              groupValue: _selectedGender,
                              onChanged: (value) => setState(() {
                                _selectedGender = value;
                              }),
                            ),
                            const Text("Others"),
                          ]),
                        ],
                      ),

                      if (genderError != null)
                        Text(genderError!,
                            style: const TextStyle(color: Colors.red)),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // DOB
                  _buildCustomInputField(
                      controller: _dateOfBirthController,
                      labelText: "Date of Birth",
                      suffixIcon: Icons.calendar_today_outlined,
                      readOnly: true,
                      onTap: _selectDate,
                      errorText: dobError),
                  const SizedBox(height: 40),

                  // BUTTON
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF26A69A), Color(0xFF4DB6AC)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: _onSignup,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: const Text("Sign Up",
                          style:
                          TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // LOGIN TEXT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Color(0xFF26A69A),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
