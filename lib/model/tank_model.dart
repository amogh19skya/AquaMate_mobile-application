class Tank {
  final String name;
  final String capacity;
  final String planted;
  final String numberOfFishes;
  final String dimension;

  Tank({
    required this.name,
    required this.capacity,
    required this.planted,
    required this.numberOfFishes,
    required this.dimension,
  });

  @override
  String toString() {
    return 'Tank details:\n  Name: $name\n  Capacity: $capacity\n  Planted: $planted\n  Fishes: $numberOfFishes\n  Dimension: $dimension';
  }
}