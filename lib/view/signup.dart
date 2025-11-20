import 'package:flutter/material.dart';

// --- CUSTOM CLIPPER FOR THE CURVED TOP SECTION ---
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8); // Start of curve below the top left
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 50, // Midpoint for the deep curve
      size.width,
      size.height * 0.8, // End of curve below the top right
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class Signinpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SigninpageState();
  }
}

class SigninpageState extends State<Signinpage> {
  // Controllers for text fields
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();

  // Gender selection
  String? _selectedGender;

  // Date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF29A091), // Teal color
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text =
            "${picked.day}/${picked.month}/${picked.year}";
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

  // --- Helper Widget for Input Fields ---
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0), // Light gray background
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                keyboardType: keyboardType,
                enabled: onTap == null, // Disable if it has onTap (for date picker)
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20.0),
                  border: InputBorder.none,
                  suffixIcon: Icon(icon, color: Colors.black54),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widget for Gender Radio Buttons ---
  Widget _buildGenderRadio(String value, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGender = value;
          });
        },
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: _selectedGender,
              onChanged: (String? value) {
                setState(() {
                  _selectedGender = value;
                });
              },
              activeColor: Color(0xFF29A091), // Teal color
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widget for Gradient Button ---
  Widget _buildGradientButton({
    required String text,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // Define the gradients and colors to match the design
    const Color tealLight = Color(0xFF80DED0);
    const Color tealDark = Color(0xFF29A091);
    const Color greenDark = Color(0xFF4C987F);

    final topGradient = const LinearGradient(
      colors: [tealLight, tealDark],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final signUpGradient = const LinearGradient(
      colors: [Color(0xFFA5E6F6), Color(0xFF85D6C4)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Curved Header Section
            ClipPath(
              clipper: CurvedClipper(),
              child: Container(
                width: size.width,
                height: size.height * 0.35, // Adjust height
                decoration: BoxDecoration(gradient: topGradient),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 180,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // 2. Welcome Text
                  const Text(
                    "New Account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Register to continue the AquaMate",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 3. Full Name Input
                  _buildInputField(
                    label: "FullName",
                    controller: _fullNameController,
                    icon: Icons.person_outline,
                    keyboardType: TextInputType.name,
                  ),

                  // 4. Email Input
                  _buildInputField(
                    label: "Email",
                    controller: _emailController,
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  // 5. Password Input
                  _buildInputField(
                    label: "Password",
                    controller: _passwordController,
                    icon: Icons.key_outlined,
                    obscureText: true,
                  ),

                  // 6. Gender Selection
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "Gender",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      _buildGenderRadio("male", "Male"),
                      _buildGenderRadio("female", "Female"),
                      _buildGenderRadio("others", "Others"),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // 7. Date of Birth Input
                  _buildInputField(
                    label: "Date of Birth",
                    controller: _dateOfBirthController,
                    icon: Icons.calendar_today,
                    onTap: () => _selectDate(context),
                  ),

                  const SizedBox(height: 20),

                  // 8. Sign Up Button (Gradient)
                  _buildGradientButton(
                    text: "Sign Up",
                    gradient: signUpGradient,
                    onTap: () {
                      // Perform sign up logic
                      print("Sign Up tapped");
                      print("Full Name: ${_fullNameController.text}");
                      print("Email: ${_emailController.text}");
                      print("Password: ${_passwordController.text}");
                      print("Gender: $_selectedGender");
                      print("Date of Birth: ${_dateOfBirthController.text}");
                      // Add your sign up logic here
                    },
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
