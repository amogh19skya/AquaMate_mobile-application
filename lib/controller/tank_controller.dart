import 'package:flutter/material.dart';
import '../model/tank_model.dart';

class TankController extends ChangeNotifier {
  final List<Tank> _tanks = [];

  List<Tank> get tanks => List.unmodifiable(_tanks);

  void saveTank(Tank tank) {
    _tanks.add(tank);
    debugPrint(tank.toString());
    notifyListeners();
  }
}

