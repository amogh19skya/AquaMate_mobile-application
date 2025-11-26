import 'package:flutter/material.dart';
import 'package:aqua_mate/routes/app_routes.dart';
import 'package:aqua_mate/widgets/shared_bottom_nav.dart';

// Placeholder Widgets - Keep them as they are
class CompatibilityCard extends StatelessWidget {
  const CompatibilityCard({super.key});
  @override
  Widget build(BuildContext context) => Container(height: 120, color: Colors.green.shade100, child: const Center(child: Text('Fish Compatibility Card')));
}

class MaintenanceCard extends StatelessWidget {
  const MaintenanceCard({super.key});
  @override
  Widget build(BuildContext context) => Container(height: 120, color: Colors.pink.shade100, child: const Center(child: Text('Maintenance Review Card')));
}

class AquariumInfoCard extends StatelessWidget {
  final String tankName;
  final Color color;
  const AquariumInfoCard({super.key, required this.tankName, required this.color});
  @override
  Widget build(BuildContext context) => Container(height: 180, color: color, child: Center(child: Text(tankName)));
}

// Main Dashboard Page
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          // 1. Custom Header (Replaces AppBar)
          _buildCustomHeader(context),

          // 2. Main Content (Scrollable Cards)
          Expanded(
            child: _buildBody(context),
          ),
        ],
      ),

      // 3. Bottom Navigation & Floating Action Button
      bottomNavigationBar: const SharedBottomNav(currentIndex: 1),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // --- Widget Builders ---

  Widget _buildCustomHeader(BuildContext context) {
    // Custom header structure matching LibraryPage's header
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF7EE8FA), // Start color (light blue)
            Color(0xFF49AEB1), // End color (dark blue)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row (Logo + Icons)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo/App Name
              Row(
                children: [
                  Image.asset(
                    "assets/images/logo.png", // Ensure this path is correct
                    height: 35,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "AquaMate",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  )
                ],
              ),

              // Icons
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_none, color: Colors.black87),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_outline, color: Colors.black87),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Welcome Message
          const Text(
            "Welcome Back Amo!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 4),

          // Status Message
          Text(
            "Your aquarium is doing great",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    const double padding = 16.0;

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: padding, vertical: 8.0),
      children: [
        // 1. Fish Compatibility Card (Green)
        const CompatibilityCard(),
        const SizedBox(height: padding),

        // 2. Maintenance Review Card (Pink/Red)
        const MaintenanceCard(),
        const SizedBox(height: padding),

        // 3. Aquarium Info Card 1 (Blue/Purple)
        AquariumInfoCard(
          tankName: 'Tank Name: Fishy Kingdom',
          color: Colors.blue.shade100,
        ),
        const SizedBox(height: padding),

        // 4. Aquarium Info Card 2 (Lighter Blue)
        AquariumInfoCard(
          tankName: 'Tank Name: Aqua Aura',
          color: Colors.indigo.shade100,
        ),
        // Space at the bottom so the last card isn't covered by the FAB
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // Navigate to the aquarium setup page
        Navigator.pushNamed(context, AppRoutes.aquariumSetup);
      },
      backgroundColor: Colors.green, // Use your app's primary color
      elevation: 2,
      shape: const CircleBorder(),
      child: const Icon(Icons.add, color: Colors.white, size: 35),
    );
  }
}