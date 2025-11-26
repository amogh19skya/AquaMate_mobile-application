import 'package:flutter/material.dart';
// Assuming these are present from your previous code
import 'package:aqua_mate/routes/app_routes.dart'; // For potential navigation
import 'package:aqua_mate/widgets/shared_bottom_nav.dart'; // Your reusable bottom nav
// import 'package:aqua_mate/constants/app_colors.dart'; // If you're using a separate colors file
import 'package:aqua_mate/controller/maintenance_controller.dart';
import 'package:aqua_mate/controller/reminder_controller.dart';
import 'package:aqua_mate/model/maintaince_model.dart';


// --- Custom Color Palette Definitions (from your previous code, ensure consistency) ---
class AppColors {
  static const Color aquaMain = Color(0xFF4ade80); // Vibrant Green
  static const Color lightBackground = Color(0xFFf3f4f6); // Light gray for overall body
  static const Color phoneBorder = Color(0xFFd1d5db); // Light border color (gray-300)
  static const Color urgentBg = Color(0xFFfef2f2); // Very Light Pink/Red
  static const Color urgentIcon = Color(0xFFf87171); // Red/Salmon for the icon
  static const Color upcomingBg = Color(0xFFecfeff); // Very Light Cyan/Blue
  static const Color upcomingIcon = Color(0xFF38bdf8); // Blue for the icon
  static const Color navBarColor = Colors.white; // White navigation bar
// Add more specific colors from the new design if needed, e.g., the new header gradient colors.
}


// --- Wrapper to simulate the rounded phone screen effect (kept from your code) ---
// This ensures consistency if you are using it to display the app inside a phone frame.
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
            color: AppColors.lightBackground,
            borderRadius: BorderRadius.circular(48),
            boxShadow: const [
              BoxShadow(
                color: Colors.black54,
                blurRadius: 25.0,
                spreadRadius: 5.0,
                offset: Offset(0, 10),
              ),
            ],
            border: Border.all(color: AppColors.phoneBorder, width: 12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36), // Inner rounding
            child: const MaintenanceScreen(), // Your app starts here
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
  late final ReminderController _reminderController;
  late final MaintenanceController _maintenanceController;

  @override
  void initState() {
    super.initState();
    _reminderController = ReminderController();
    _maintenanceController = MaintenanceController(reminderController: _reminderController);
  }

  @override
  void dispose() {
    _maintenanceController.dispose();
    _reminderController.dispose();
    super.dispose();
  }

  // Helper widget to build the task cards (UPDATED FOR NEW UI)
  Widget _buildTaskCard({
    required String title,
    required String time,
    required Color iconColor,
    required Color iconBgColor,
    required IconData icon,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.white, // Task cards now have white background
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Icon & Circular Color Block (UPDATED)
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle, // <-- Changed to circular
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
                      const Icon(Icons.access_time, size: 16, color: Colors.grey), // Time icon always grey
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600], // Time text always grey
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Notification Bell Button (Kept)
            IconButton(
              onPressed: () {
                // Handle notification bell tap
              },
              icon: Icon(
                Icons.notifications,
                color: iconColor, // Notification bell color matches card's accent
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatSchedule(DateTime dateTime) {
    final time = TimeOfDay.fromDateTime(dateTime);
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'am' : 'pm';
    return '${dateTime.day}/${dateTime.month} $hour:$minute $period';
  }

  Widget _buildTaskSection({
    required String title,
    required List<MaintenanceTask> tasks,
    required Color iconColor,
    required Color iconBgColor,
    required IconData icon,
    required String emptyText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        if (tasks.isEmpty)
          _buildEmptyState(emptyText)
        else
          ...tasks.map(
            (task) => _buildTaskCard(
              title: task.task,
              time: _formatSchedule(task.scheduledFor),
              icon: icon,
              iconColor: iconColor,
              iconBgColor: iconBgColor,
            ),
          ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.grey),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for the custom header section (UPDATED FOR NEW UI)
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 24, right: 24, bottom: 20), // Reduced bottom padding
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7EE8FA),
            Color(0xFF49AEB1)], // A fresh blue gradient (adjust if needed)
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // No bottom radius here, as the content now sits flush below it.
        // If you want a slight curve, add:
        // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
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
                  Image.asset(
                    "assets/images/logo.png", // Ensure this path is correct
                    height: 35,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'AquaMate',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87), // Changed to black for contrast
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none, color: Colors.black87, size: 28), // Changed to black
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person_outline, color: Colors.black87, size: 28), // Changed to black
                  ),
                ],
              ),
            ],
          ),
          // Removed the "Maintenance" title and subtitle from here
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _maintenanceController,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.transparent, // Background handled by the wrapper

          // Floating Action Button (Moved to endFloat as per screenshot)
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Navigate to the reminder setup form
              Navigator.pushNamed(context, AppRoutes.reminderSetup);
            },
            backgroundColor: AppColors.aquaMain,
            shape: const CircleBorder(),
            elevation: 8,
            child: const Icon(Icons.add, color: Colors.white, size: 32),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // Changed to endFloat

          // Custom Bottom Navigation Bar
          bottomNavigationBar: const SharedBottomNav(currentIndex: 0), // Maintenance is now index 0

          // Main Content Area with Custom Header
          body: Column(
            children: [
              // Header Section
              _buildHeader(),

              // Scrollable Content Body (Expanded to fill remaining space)
              Expanded(
                child: Container(
                  color: AppColors.lightBackground, // Light background for the scrollable area
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Reminder Title and Subtitle (NEW LOCATION) ---
                        const Text(
                          'Reminder',
                          style: TextStyle(
                              fontSize: 32, // Adjusted font size
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                              letterSpacing: 0.5),
                        ),
                        Text(
                          'Keeping your aquarium',
                          style: TextStyle(fontSize: 16, color: Colors.grey.shade700), // Darker grey
                        ),
                        const SizedBox(height: 30), // More space before "Urgent"

                        _buildTaskSection(
                          title: 'Urgent',
                          tasks: _maintenanceController.urgent,
                          icon: Icons.priority_high,
                          iconColor: AppColors.urgentIcon,
                          iconBgColor: AppColors.urgentBg,
                          emptyText: 'All caught up! No urgent tasks right now.',
                        ),
                        _buildTaskSection(
                          title: 'Upcoming',
                          tasks: _maintenanceController.upcoming,
                          icon: Icons.schedule,
                          iconColor: AppColors.upcomingIcon,
                          iconBgColor: AppColors.upcomingBg,
                          emptyText: 'Nothing scheduled. Add a reminder to get started.',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}