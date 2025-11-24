import 'package:flutter/material.dart';

import 'package:aqua_mate/routes/app_routes.dart';
import 'package:aqua_mate/widgets/shared_bottom_nav.dart';

// Assuming you are using the Get package based on your structure.
// If not, replace 'GetView' with 'StatelessWidget' or 'StatefulWidget'.
// import 'package:get/get.dart';
// import '../../controller/dashboard_controller.dart';

// Placeholder Widgets - You will create these in the next steps.
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
class DashboardPage extends StatelessWidget /* Replace with GetView<DashboardController> if using GetX */ {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Top Section (App Bar)
      appBar: _buildAppBar(context),

      // 2. Main Content (Scrollable Cards)
      body: _buildBody(context),

      // 3. Bottom Navigation & Floating Action Button
      bottomNavigationBar: const SharedBottomNav(currentIndex: 1),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // --- Widget Builders ---

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // You can replace this with a PreferredSize widget for better control
    // or just a standard AppBar. We'll use a standard one for simplicity here.
    return AppBar(
      // The leading icon/logo section
      leadingWidth: 150,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Row(
          children: [
            // Placeholder for the AquaMate logo
            const Icon(Icons.waves, color: Colors.teal, size: 32),
            const SizedBox(width: 8),
            Text(
              'AquaMate',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),

      // The trailing notification and user icon
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, size: 28),
          onPressed: () { /* Handle notification tap */ },
        ),
        IconButton(
          icon: const Icon(Icons.account_circle, size: 28),
          onPressed: () { /* Handle profile tap */ },
        ),
        const SizedBox(width: 8),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  // Data from the controller: controller.userName
                  'Welcome Back Amo !',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                Text(
                  // Data from the controller: controller.statusMessage
                  'Your aquarium is doing great',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    const double padding = 16.0;

    // Using a ListView to allow scrolling if many aquariums are added
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
        // Add more AquariumInfoCard widgets here dynamically from a list
        // in your DashboardController if needed.

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