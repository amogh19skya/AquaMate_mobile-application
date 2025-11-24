// lib/model/reminder_model.dart

enum ReminderType {
  fishFeed,
  waterChange,
  tankCleaning,
  filterWash,
}

class ReminderModel {
  final String tankName;
  final ReminderType type;
  final DateTime scheduledDate;

  ReminderModel({
    required this.tankName,
    required this.type,
    required this.scheduledDate,
  });

  // --- Serialization Methods ---

  /// Converts the ReminderModel object into a Map (JSON) format.
  /// This is used when SAVING the object to a database or sending it to an API.
  Map<String, dynamic> toJson() {
    return {
      'tankName': tankName,
      // Convert the Dart enum to a simple string for storage/API
      'type': type.toString().split('.').last,
      // Convert DateTime to a universal string format (ISO 8601)
      'scheduledDate': scheduledDate.toIso8601String(),
    };
  }

  /// Creates a ReminderModel object from a Map (JSON) format.
  /// This is used when LOADING the object from a database or receiving it from an API.
  factory ReminderModel.fromJson(Map<String, dynamic> json) {
    // Helper function to convert the stored string back into the Enum
    ReminderType stringToReminderType(String typeString) {
      // The Dart 'case' statement is ideal for converting string representations
      // back into their enum values.
      switch (typeString) {
        case 'fishFeed':
          return ReminderType.fishFeed;
        case 'waterChange':
          return ReminderType.waterChange;
        case 'tankCleaning':
          return ReminderType.tankCleaning;
        case 'filterWash':
          return ReminderType.filterWash;
        default:
        // Handle unknown or bad data gracefully
          throw ArgumentError('Invalid ReminderType string: $typeString');
      }
    }

    return ReminderModel(
      tankName: json['tankName'] as String,
      type: stringToReminderType(json['type'] as String),
      // Parse the ISO 8601 string back into a DateTime object
      scheduledDate: DateTime.parse(json['scheduledDate'] as String),
    );
  }
}