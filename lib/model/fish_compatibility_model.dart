// lib/model/fish_compatibility_model.dart

class FishCompatibilityModel {
  static const Map<String, List<String>> compatibility = {
    "Goldfish": ["Guppy", "Molly"],
    "Guppy": ["Goldfish", "Tetra", "Platy"],
    "Betta": ["Snail"],
    "Tetra": ["Guppy", "Platy"],
    "Molly": ["Goldfish", "Platy"],
    "Platy": ["Guppy", "Tetra", "Molly"],
    "Snail": ["Betta"],
  };
}
