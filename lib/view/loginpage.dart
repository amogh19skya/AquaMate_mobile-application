import 'package:flutter/material.dart';

import 'package:aqua_mate/routes/app_routes.dart';

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

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // NOTE: Uncomment and set up SharedPreferences package to enable this logic
    // readfromstorage();
  }

  // --- Helper Widget for Input Fields ---
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
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
          Container(
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
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 20.0),
                border: InputBorder.none,
                suffixIcon: Icon(icon, color: Colors.black54),
                // Remove the default outline
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

    // Define the gradients and colors to match the image theme
    const Color tealLight = Color(0xFF80DED0);
    const Color tealDark = Color(0xFF29A091);
    const Color greenDark = Color(0xFF4C987F);

    final topGradient = const LinearGradient(
      colors: [tealLight, tealDark],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final loginGradient = const LinearGradient(
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
                      height: 180, // <-- LOGO SIZE INCREASED TO 180
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
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Sign in to continue the AquaMate",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 3. Email Input
                  _buildInputField(
                    label: "Email",
                    controller: _emailController,
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  // 4. Password Input
                  _buildInputField(
                    label: "Password",
                    controller: _passwordController,
                    icon: Icons.key_outlined,
                    obscureText: true,
                  ),

                  // Forgot Password Text
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // Handle forgot password tap
                        print("Forgot Password tapped");
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 5. Login Button (Gradient)
                  _buildGradientButton(
                    text: "Login",
                    gradient: loginGradient,
                    onTap: () {
                      // Perform login logic
                      print("Login tapped with Email: ${_emailController.text}");
                    },
                  ),

                  // 6. Sign Up Button (Solid Color)
                  _buildGradientButton(
                    text: "Sign Up",
                    gradient: const LinearGradient(colors: [greenDark, greenDark]),
                    onTap: () async {
                      final result = await Navigator.pushNamed(context, AppRoutes.signup);
                      if (!mounted) return;
                      if (result == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Registration successful. Please log in.")),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}