import 'package:flutter/material.dart';
import '../model/reminder_model.dart'; // Import your model

class ReminderController extends ChangeNotifier {
  // State: List of all current reminders
  final List<ReminderModel> _reminders = [];
  List<ReminderModel> get reminders => _reminders;

  // State: Data held by the New Reminder Form (optional, but clean)
  String _tankName = '';
  ReminderType? _selectedType;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  // --- SETTERS (Called by the UI) ---

  void setTankName(String name) {
    _tankName = name;
  }

  void setSelectedType(String taskName) {
    // Convert the UI string back to the ReminderType enum
    switch (taskName) {
      case 'Fish Feed':
        _selectedType = ReminderType.fishFeed;
        break;
      case 'Water Change':
        _selectedType = ReminderType.waterChange;
        break;
      case 'Tank Cleaning':
        _selectedType = ReminderType.tankCleaning;
        break;
      case 'Filter Wash':
        _selectedType = ReminderType.filterWash;
        break;
      default:
        _selectedType = null;
    }
    // Note: We don't call notifyListeners() here if this doesn't change the UI directly.
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners(); // Notify the UI to update the displayed date
  }

  void setSelectedTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners(); // Notify the UI to update the displayed time
  }

  // --- BUSINESS LOGIC (Called by the UI's "Set" button) ---

  bool saveNewReminder() {
    // 1. Validation
    if (_tankName.isEmpty || _selectedType == null || _selectedDate == null || _selectedTime == null) {
      // You could throw an error or handle validation feedback here
      return false; // Return false if validation fails
    }

    // 2. Combine Date and Time
    final DateTime finalScheduledDate = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    // 3. Create the Model object
    final newReminder = ReminderModel(
      tankName: _tankName,
      type: _selectedType!,
      scheduledDate: finalScheduledDate,
    );

    // 4. Save to the list (In a real app, this is where you'd call an API/DB service)
    _reminders.add(newReminder);

    // 5. Clear the form data after saving
    _tankName = '';
    _selectedType = null;
    _selectedDate = null;
    _selectedTime = null;

    // Notify listeners so other parts of the app (like a reminder list screen) update
    notifyListeners();
    return true; // Return true on success
  }

  // Helper function to clear the form
  void clearForm() {
    _tankName = '';
    _selectedType = null;
    _selectedDate = null;
    _selectedTime = null;
    notifyListeners(); // Notify UI to reset
  }
}