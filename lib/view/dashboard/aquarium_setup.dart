 import 'package:flutter/material.dart';

// --- Custom Fish Painter ---
class FishPainter extends CustomPainter {
  final Color fishColor;

  FishPainter({required this.fishColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = fishColor
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw fish body (ellipse)
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: size.width * 0.6,
        height: size.height * 0.5,
      ),
      const Radius.circular(20),
    );
    canvas.drawRRect(bodyRect, paint);

    // Draw tail (triangle)
    final tailPath = Path()
      ..moveTo(centerX - size.width * 0.3, centerY)
      ..lineTo(centerX - size.width * 0.5, centerY - size.height * 0.2)
      ..lineTo(centerX - size.width * 0.5, centerY + size.height * 0.2)
      ..close();
    canvas.drawPath(tailPath, paint);

    // Draw eye
    final eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(centerX + size.width * 0.15, centerY - size.height * 0.1),
      size.width * 0.08,
      eyePaint,
    );

    final pupilPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(centerX + size.width * 0.15, centerY - size.height * 0.1),
      size.width * 0.04,
      pupilPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// --- Custom Color Palette for Aquarium Setup ---
class AquariumColors {
  static const Color lightBlue = Color(0xFFB3E5FC); // Light blue for Fresh Water card
  static const Color lightGreen = Color(0xFFC8E6C9); // Light green for Salt Water card
  static const Color tealMain = Color(0xFF80DED0); // Main teal color
  static const Color tealDark = Color(0xFF29A091); // Dark teal
  static const Color navBarColor = Colors.white;
  static const Color aquaMain = Color(0xFF4ade80);
}

class AquariumSetupPage extends StatefulWidget {
  const AquariumSetupPage({super.key});

  @override
  State<AquariumSetupPage> createState() => _AquariumSetupPageState();
}

class _AquariumSetupPageState extends State<AquariumSetupPage> {
  int _selectedIndex = 0; // For bottom navigation
  String? _selectedAquariumType; // 'fresh' or 'salt'

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Build header with logo and icons
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AquariumColors.tealMain, AquariumColors.tealDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          // Top bar with logo and icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo and text
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 40,
                    width: 40,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'AquaMate',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              // Bell and profile icons
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.notifications_none,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build progress indicator
  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Step 1 of 5',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                '35%',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AquariumColors.tealDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.35,
              minHeight: 8,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(
                AquariumColors.tealDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build fish icon widget
  Widget _buildFishIcon({required Color fishColor}) {
    return CustomPaint(
      size: const Size(80, 80),
      painter: FishPainter(fishColor: fishColor),
    );
  }

  // Build aquarium type selection card
  Widget _buildAquariumCard({
    required String title,
    required String subtitle,
    required Color cardColor,
    required String type,
    required Color fishColor,
  }) {
    final isSelected = _selectedAquariumType == type;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAquariumType = type;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AquariumColors.tealDark : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Fish icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: _buildFishIcon(fishColor: fishColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build bottom navigation bar
  Widget _buildBottomNavBar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AquariumColors.navBarColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: BottomNavigationBar(
          backgroundColor: AquariumColors.navBarColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: AquariumColors.aquaMain,
          unselectedItemColor: Colors.grey[500],
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box_outlined),
              label: 'Maintenance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          _buildHeader(),
          
          // Title Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Aquarium Setup',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Step by step guidance',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Progress Indicator
          _buildProgressIndicator(),

          // Main Content - Aquarium Type Selection
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: const Text(
                      'Choose Aquarium type',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  
                  // Fresh Water Card
                  _buildAquariumCard(
                    title: 'Fresh Water',
                    subtitle: 'For beginner/experienced',
                    cardColor: AquariumColors.lightBlue,
                    type: 'fresh',
                    fishColor: const Color(0xFFE91E63), // Red/Pink for Betta
                  ),

                  // Salt Water Card
                  _buildAquariumCard(
                    title: 'Salt Water',
                    subtitle: 'For beginner/experienced',
                    cardColor: AquariumColors.lightGreen,
                    type: 'salt',
                    fishColor: const Color(0xFF2196F3), // Blue for Discus
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Bottom Navigation Bar
          _buildBottomNavBar(),
        ],
      ),
    );
  }
}

