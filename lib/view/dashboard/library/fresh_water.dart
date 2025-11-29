import 'package:flutter/material.dart';
import 'fish_detail_page.dart';


class FreshWaterFishPage extends StatelessWidget {
  const FreshWaterFishPage({super.key});

  final List<Map<String, dynamic>> fishList = const [
    {
      "name": "Goldfish",
      "scientific": "Carassius auratus",
      "image": "assets/images/library/fresh_fish/golden-fish-black.jpg",
      "desc": "A peaceful freshwater fish suitable for beginners.",
      "details": {
        "temp": "20°C - 23°C",
        "ph": "6.5 - 7.5",
        "tank": "75+ liters",
        "care": "Easy",
        "food": "Flakes, Pellets, Vegetables",
        "behavior": "Peaceful, active",
        "about":
        "Goldfish are popular freshwater fish known for their bright colors and friendly nature. They thrive in cooler water and require proper filtration to stay healthy. Goldfish can live more than 10 years if properly cared for."
      }
    },
    {
      "name": "Guppy",
      "scientific": "Poecilia reticulata",
      "image": "assets/images/library/fresh_fish/guppy-blue.webp",
      "desc": "Colorful and active fish that thrive in small tanks.",
      "details": {
        "temp": "22°C - 28°C",
        "ph": "6.8 - 7.8",
        "tank": "40+ liters",
        "care": "Very Easy",
        "food": "Flakes, Live food",
        "behavior": "Community-friendly",
        "about":
        "Guppies are small, very colorful fish loved by beginners. They reproduce quickly and come in many varieties. They are peaceful and do well in community tanks."
      }
    },
    {
      "name": "Betta",
      "scientific": "Betta splendens",
      "image": "assets/images/library/fresh_fish/betta.jpg",
      "desc": "A stunning fish with flowing fins. Males must live alone.",
      "details": {
        "temp": "25°C - 28°C",
        "ph": "6.5 - 7.0",
        "tank": "20+ liters",
        "care": "Medium",
        "food": "Pellets, Frozen food",
        "behavior": "Territorial",
        "about":
        "Betta fish are known for their beautiful long fins and bright colors. They are territorial and should be housed alone or with compatible tank mates. Bettas require warm and stable water conditions."
      }
    },
    {
      "name": "Angelfish",
      "scientific": "Pterophyllum scalare",
      "image": "assets/images/library/fresh_fish/blue_angelfish.png",
      "desc": "Elegant fish with a unique body shape.",
      "details": {
        "temp": "24°C - 29°C",
        "ph": "6.8 - 7.8",
        "tank": "100+ liters",
        "care": "Medium",
        "food": "Flakes, Pellets, Live food",
        "behavior": "Semi-aggressive",
        "about":
        "Angelfish are graceful and add beauty to freshwater tanks. They prefer tall tanks and require stable water quality. They can be semi-aggressive depending on tank mates."
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fresh Water Fish Library"),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: fishList.length,
        itemBuilder: (context, index) {
          final fish = fishList[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FishDetailPage(
                    name: fish["name"],
                    scientific: fish["scientific"],
                    image: fish["image"],
                    details: fish["details"],
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(1, 3),
                  )
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16)),
                    child: Image.asset(
                      fish["image"],
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fish["name"],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            fish["scientific"],
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                                fontStyle: FontStyle.italic),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            fish["desc"],
                            style: TextStyle(
                                fontSize: 14, color: Colors.grey.shade700),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
