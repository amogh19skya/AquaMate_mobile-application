import 'package:flutter/material.dart';
import 'package:aqua_mate/controller/fish_compatibility_controller.dart';
import 'package:aqua_mate/widgets/shared_bottom_nav.dart';

class CompatibilityCheckerPage extends StatefulWidget {
  const CompatibilityCheckerPage({super.key});

  @override
  State<CompatibilityCheckerPage> createState() => _CompatibilityCheckerPageState();
}

class _CompatibilityCheckerPageState extends State<CompatibilityCheckerPage> {
  final controller = FishCompatibilityController();

  String? fish1;
  String? fish2;
  String result = "";

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF7EE8FA),
            Color(0xFF49AEB1),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
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
                  ),
                ],
              ),
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
          const Text(
            "Compatibility Checker",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Check if two fish species can thrive together.",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fishList = controller.getFishList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: fish1,
                    decoration: InputDecoration(
                      labelText: "Select Fish 1",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: fishList
                        .map((fish) => DropdownMenuItem(value: fish, child: Text(fish)))
                        .toList(),
                    onChanged: (value) => setState(() => fish1 = value),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: fish2,
                    decoration: InputDecoration(
                      labelText: "Select Fish 2",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    items: fishList
                        .map((fish) => DropdownMenuItem(value: fish, child: Text(fish)))
                        .toList(),
                    onChanged: (value) => setState(() => fish2 = value),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          result = controller.check(fish1, fish2);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF49AEB1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        "Check Compatibility",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (result.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: result.contains("✔")
                            ? Colors.green.shade50
                            : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: result.contains("✔")
                              ? Colors.green.shade200
                              : Colors.red.shade200,
                        ),
                      ),
                      child: Text(
                        result,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: result.contains("✔")
                              ? Colors.green.shade800
                              : Colors.red.shade700,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const SharedBottomNav(currentIndex: 1),
    );
  }
}
