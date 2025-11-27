// lib/controller/fish_compatibility_controller.dart

import 'package:aqua_mate/model/fish_compatibility_model.dart';

class FishCompatibilityController {
  String check(String? fish1, String? fish2) {
    if (fish1 == null || fish2 == null) {
      return "Please select both fish.";
    }

    if (fish1 == fish2) {
      return "Same species — compatible.";
    }

    final map = FishCompatibilityModel.compatibility;

    if (map[fish1]!.contains(fish2)) {
      return "✔ Compatible! They can live together.";
    }

    return "❌ Not Compatible! Avoid keeping them together.";
  }

  List<String> getFishList() {
    return FishCompatibilityModel.compatibility.keys.toList();
  }
}
