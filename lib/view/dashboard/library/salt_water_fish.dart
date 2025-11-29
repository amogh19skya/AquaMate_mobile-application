import 'package:flutter/material.dart';
import 'salt_water_fish_detail_page.dart';

class SaltWaterFishPage extends StatelessWidget {
  const SaltWaterFishPage({super.key});

  final List<Map<String, dynamic>> fishList = const [
    {
      "name": "Clownfish",
      "scientific": "Amphiprioninae",
      "image": "assets/images/library/salt_fish/clown-fish.webp",
      "desc": "Small, peaceful fish known for bonding with sea anemones.",
      "details": {
        "temp": "24°C - 27°C",
        "ph": "8.1 - 8.4",
        "tank": "75+ liters",
        "care": "Easy",
        "food": "Pellets, Flakes, Frozen food",
        "behavior": "Peaceful, pairs recommended",
        "about":
        "Clownfish are iconic saltwater species known for their bright orange colors and symbiotic relationship with sea anemones. They are hardy and great for beginners in marine aquariums."
      }
    },
    {
      "name": "Blue Tang",
      "scientific": "Paracanthurus hepatus",
      "image": "assets/images/library/salt_fish/blue_tang.jpeg",
      "desc": "Fast swimmers that require large tanks.",
      "details": {
        "temp": "24°C - 27°C",
        "ph": "8.1 - 8.4",
        "tank": "300+ liters",
        "care": "Hard",
        "food": "Algae, Seaweed, Pellets",
        "behavior": "Active swimmer",
        "about":
        "Blue Tangs are active and require a spacious tank. They are sensitive to water changes and need strong filtration. Made famous by the movie 'Finding Dory'."
      }
    },
    {
      "name": "Yellow Tang",
      "scientific": "Zebrasoma flavescens",
      "image": "assets/images/library/salt_fish/yellow_tang.jpeg",
      "desc": "Bright yellow, hardy, and peaceful marine fish.",
      "details": {
        "temp": "24°C - 28°C",
        "ph": "8.0 - 8.4",
        "tank": "200+ liters",
        "care": "Medium",
        "food": "Algae, Greens, Seaweed",
        "behavior": "Semi-aggressive",
        "about":
        "Yellow Tangs are popular saltwater fish known for their striking yellow color. They need plenty of algae to graze on and a tank with good swimming space."
      }
    },
    {
      "name": "Mandarin Dragonet",
      "scientific": "Synchiropus splendidus",
      "image": "assets/images/library/salt_fish/mandarin_dragonet.jpg",
      "desc": "Extremely colorful but requires live food.",
      "details": {
        "temp": "24°C - 27°C",
        "ph": "8.1 - 8.4",
        "tank": "100+ liters (mature tank)",
        "care": "Hard",
        "food": "Live copepods",
        "behavior": "Peaceful",
        "about":
        "Mandarin Dragonets are one of the most beautiful marine fish but are difficult to care for. They need an established tank full of copepods to survive."
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Salt Water Fish Library"),
        backgroundColor: Colors.blueAccent,
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
                  builder: (_) => SaltWaterFishDetailPage(
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
                      bottomLeft: Radius.circular(16),
                    ),
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
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            fish["desc"],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
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
