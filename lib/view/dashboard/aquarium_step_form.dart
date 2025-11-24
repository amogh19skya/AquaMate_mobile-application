import 'package:flutter/material.dart';

// --- Custom Color Palette for Aquarium Step Form ---
class AquariumStepFormColors {
  static const Color lightBlue = Color(0xFFB3E5FC); // Light blue/cyan
  static const Color lightGreen = Color(0xFFC8E6C9); // Light green
  static const Color tealMain = Color(0xFF80DED0); // Main teal
  static const Color tealDark = Color(0xFF29A091); // Dark teal
  static const Color aquaMain = Color(0xFF4ade80); // Vibrant green
  static const Color cancelRed = Color(0xFFE53935); // Red for cancel button
  static const Color navBarColor = Colors.grey; // Gray navigation bar
  static const Color inputBg = Color(0xFFF5F5F5); // Light gray for inputs
}

class AquariumStepFormPage extends StatefulWidget {
  const AquariumStepFormPage({super.key});

  @override
  State<AquariumStepFormPage> createState() => _AquariumStepFormPageState();
}

class _AquariumStepFormPageState extends State<AquariumStepFormPage> {
  int _selectedIndex = 0; // For bottom navigation (Maintenance is active)
  
  // Form controllers
  final TextEditingController _tankNameController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _plantedController = TextEditingController();
  final TextEditingController _noOfFishesController = TextEditingController();
  final TextEditingController _dimensionController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _tankNameController.dispose();
    _capacityController.dispose();
    _plantedController.dispose();
    _noOfFishesController.dispose();
    _dimensionController.dispose();
    super.dispose();
  }

  // Build header with gradient background
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AquariumStepFormColors.lightBlue, AquariumStepFormColors.lightGreen],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top bar with logo and icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo and AquaMate text
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
                      color: Colors.black87,
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
                      color: Colors.black87,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person_outline,
                      color: Colors.black87,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Maintenance title
          const Text(
            'Maintenance',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AquariumStepFormColors.aquaMain,
            ),
          ),
          const SizedBox(height: 4),
          // Form subtitle
          Text(
            'Form',
            style: TextStyle(
              fontSize: 18,
              color: AquariumStepFormColors.aquaMain.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Build input field
  Widget _buildInputField({
    required String placeholder,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AquariumStepFormColors.inputBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: placeholder,
          hintStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  // Build action buttons
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          // Cancel button
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AquariumStepFormColors.cancelRed,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Save button
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AquariumStepFormColors.aquaMain,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // Handle save action
                    // You can add validation and save logic here
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Maintenance form saved successfully!'),
                        backgroundColor: AquariumStepFormColors.aquaMain,
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build bottom navigation bar
  Widget _buildBottomNavBar() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AquariumStepFormColors.navBarColor,
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
          backgroundColor: AquariumStepFormColors.navBarColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black87,
          unselectedItemColor: Colors.black54,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.check_box_outlined),
              activeIcon: Icon(Icons.check_box),
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

          // Form Section
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tank Name
                  _buildInputField(
                    placeholder: 'Tank Name',
                    controller: _tankNameController,
                  ),

                  // Capacity
                  _buildInputField(
                    placeholder: 'Capacity',
                    controller: _capacityController,
                    keyboardType: TextInputType.number,
                  ),

                  // Planted
                  _buildInputField(
                    placeholder: 'Planted',
                    controller: _plantedController,
                  ),

                  // No of Fishes
                  _buildInputField(
                    placeholder: 'No of Fishes',
                    controller: _noOfFishesController,
                    keyboardType: TextInputType.number,
                  ),

                  // Dimension
                  _buildInputField(
                    placeholder: 'Dimension',
                    controller: _dimensionController,
                  ),

                  // Action Buttons
                  _buildActionButtons(),
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

