import 'package:flutter/material.dart';

// --- Custom Color Palette Definitions ---
// Updated colors for a light/white theme.
class AppColors {
  static const Color aquaMain = Color(0xFF4ade80); // Vibrant Green (Kept)
  static const Color lightBackground = Color(0xFFf3f4f6); // Light gray for overall body
  static const Color phoneBorder = Color(0xFFd1d5db); // Light border color (gray-300)
  static const Color urgentBg = Color(0xFFfef2f2); // Very Light Pink/Red (Kept)
  static const Color urgentIcon = Color(0xFFf87171); // Red/Salmon for the icon (Kept)
  static const Color upcomingBg = Color(0xFFecfeff); // Very Light Cyan/Blue (Kept)
  static const Color upcomingIcon = Color(0xFF38bdf8); // Blue for the icon (Kept)
  static const Color navBarColor = Colors.white; // White navigation bar
}

void main() {
  runApp(const AquaMateApp());
}

class AquaMateApp extends StatelessWidget {
  const AquaMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AquaMate',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter', // Assuming 'Inter' font is available or use default
        // Use a light gray background for the overall app wrapper
        scaffoldBackgroundColor: AppColors.lightBackground,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(AppColors.aquaMain.value, const <int, Color>{
            50: AppColors.aquaMain,
            100: AppColors.aquaMain,
            200: AppColors.aquaMain,
            300: AppColors.aquaMain,
            400: AppColors.aquaMain,
            500: AppColors.aquaMain,
            600: AppColors.aquaMain,
            700: AppColors.aquaMain,
            800: AppColors.aquaMain,
            900: AppColors.aquaMain,
          }),
        ),
      ),
      home: const MobileScreenWrapper(),
    );
  }
}

// Wrapper to simulate the rounded phone screen effect
class MobileScreenWrapper extends StatelessWidget {
  const MobileScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 400, // Max width for the simulated phone
          height: 800, // Fixed height for the simulated phone
          decoration: BoxDecoration(
            color: AppColors.lightBackground, // Light background for the screen interior
            borderRadius: BorderRadius.circular(48),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 25.0,
                spreadRadius: 5.0,
                offset: Offset(0, 10),
              ),
            ],
            // Light border for the simulated phone body
            border: Border.all(color: AppColors.phoneBorder, width: 12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36), // Inner rounding
            child: const MaintenanceScreen(),
          ),
        ),
      ),
    );
  }
}

// --- Main Maintenance Screen Implementation ---
class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  int _selectedIndex = 0; // State for bottom navigation

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Helper widget to build the task cards
  Widget _buildTaskCard({
    required String title,
    required String time,
    required Color iconColor,
    required Color iconBgColor,
    required IconData icon,
    required bool isUrgent,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Icon & Color Block
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 32),
            ),
            const SizedBox(width: 16),
            // Title and Time
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: isUrgent ? AppColors.urgentIcon : Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 14,
                          color: isUrgent ? AppColors.urgentIcon : Colors.grey[600],
                          fontWeight: isUrgent ? FontWeight.w500 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Notification Bell Button
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: isUrgent ? AppColors.urgentIcon : Colors.grey[400],
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for the custom header section
  Widget _buildHeader() {
    // Gradient header with white text remains the same for contrast
    return Container(
      padding: const EdgeInsets.only(top: 60, left: 24, right: 24, bottom: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4ade80), Color(0xFF10b981)], // green-400 to green-600
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar (App Name & Icons)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Fish Icon (Placeholder for the custom SVG)
                  const Icon(Icons.waves, size: 32, color: Colors.white),
                  const SizedBox(width: 8),
                  const Text(
                    'AquaMate',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person_outline, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Title and Subtitle
          const Text(
            'Maintenance',
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.5),
          ),
          Text(
            'Keeping your aquarium',
            style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.9)),
          ),
        ],
      ),
    );
  }

  // Helper widget for the bottom navigation bar
  Widget _buildBottomNavBar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.navBarColor, // Changed to white
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Adjusted shadow for light theme
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
          backgroundColor: AppColors.navBarColor, // Changed to white
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColors.aquaMain,
          unselectedItemColor: Colors.grey[500], // Darker icons for contrast on white
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box_outlined), // Maintenance (Active)
              label: 'Maintenance',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), // Dashboard
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined), // Library
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined), // Settings
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
      backgroundColor: Colors.transparent, // Background handled by the wrapper

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.aquaMain,
        shape: const CircleBorder(),
        elevation: 8,
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // Custom Bottom Navigation Bar
      bottomNavigationBar: _buildBottomNavBar(),

      // Main Content Area with Custom Header
      body: Column(
        children: [
          // Header Section
          _buildHeader(),

          // Scrollable Content Body
          Expanded(
            child: Container(
              color: AppColors.lightBackground, // Light background for the scrollable area
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Urgent Tasks Section ---
                    const Text(
                      'Urgent',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87, // Dark text color for light theme
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Urgent Task 1: Fish Feed
                    _buildTaskCard(
                      title: 'Fish Feed',
                      time: 'Today 6:00 pm',
                      icon: Icons.ramen_dining,
                      iconColor: AppColors.urgentIcon,
                      iconBgColor: AppColors.urgentBg,
                      isUrgent: true,
                    ),

                    const SizedBox(height: 24),

                    // --- Upcoming Tasks Section ---
                    const Text(
                      'Upcoming',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87, // Dark text color for light theme
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Upcoming Task 1: Water Change
                    _buildTaskCard(
                      title: 'Water Change',
                      time: 'Tomorrow 8:00 am',
                      icon: Icons.opacity,
                      iconColor: AppColors.upcomingIcon,
                      iconBgColor: AppColors.upcomingBg,
                      isUrgent: false,
                    ),
                    // Upcoming Task 2: Check Water Quality
                    _buildTaskCard(
                      title: 'Check Water Quality',
                      time: 'Tomorrow 7:00 pm',
                      icon: Icons.science,
                      iconColor: Colors.grey[600]!,
                      iconBgColor: Colors.grey[200]!,
                      isUrgent: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}