import 'package:flutter/material.dart';
import 'package:aqua_mate/widgets/shared_bottom_nav.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ------- HEADER --------
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF7EE8FA),
                  Color(0xFF80FF72),
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
                        )
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
                  "Resources Library",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "More Knowledge",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ------- MAIN CONTENT --------
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildImageCard(
                    label: "Fresh Water",
                    imagePath: "assets/images/library/freshwater.png",
                  ),
                  const SizedBox(height: 16),

                  _buildImageCard(
                    label: "Salt Water",
                    imagePath: "assets/images/saltwater.png",
                  ),
                  const SizedBox(height: 16),

                  _buildImageCard(
                    label: "Aquascape",
                    imagePath: "assets/images/aquascape.png",
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // ------- SHARED BOTTOM NAV -------
      bottomNavigationBar: SharedBottomNav(currentIndex: 2),
    );
  }

  // -------- IMAGE CARD WIDGET --------
  Widget _buildImageCard({required String label, required String imagePath}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: label == "Fresh Water"
              ? [const Color(0xFF7EE8FA), const Color(0xFF4FC3F7)]
              : label == "Salt Water"
                  ? [const Color(0xFF80FF72), const Color(0xFF66BB6A)]
                  : [const Color(0xFFB39DDB), const Color(0xFF9575CD)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.all(12),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          shadows: [
            Shadow(blurRadius: 6, color: Colors.black87),
          ],
        ),
      ),
    );
  }
}
