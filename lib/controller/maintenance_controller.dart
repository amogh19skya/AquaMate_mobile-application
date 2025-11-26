import 'package:flutter/material.dart';

import '../model/maintaince_model.dart';
import '../model/reminder_model.dart';
import 'reminder_controller.dart';

class MaintenanceController extends ChangeNotifier {
  final ReminderController reminderController;
  late final VoidCallback _reminderListener;

  MaintenanceController({required this.reminderController}) {
    _reminderListener = () => notifyListeners();
    reminderController.addListener(_reminderListener);
  }

  @override
  void dispose() {
    reminderController.removeListener(_reminderListener);
    super.dispose();
  }

  List<MaintenanceTask> get allTasks {
    // ⬇️ FIX APPLIED HERE ⬇️
    // The items in reminderController.reminders are now correctly mapped
    // to MaintenanceTask properties using the ReminderModel fields.
    return reminderController.reminders.map((r) {
      // We convert the ReminderType enum to a readable string (e.g., 'fishFeed')
      String taskTitle = r.type.toString().split('.').last;

      // Capitalize the first letter for a clean display (e.g., 'FishFeed')
      taskTitle = '${taskTitle[0].toUpperCase()}${taskTitle.substring(1)}';

      return MaintenanceTask(
        tankName: r.tankName,
        // Use the formatted string derived from the ReminderType
        task: taskTitle,
        // Use the correct date field from ReminderModel
        scheduledFor: r.scheduledDate,
      );
    }).toList();
  }

  List<MaintenanceTask> get urgent {
    return allTasks
        .where((t) => t.isOverdue)
        .toList()
      ..sort((a, b) => a.scheduledFor.compareTo(b.scheduledFor));
  }

  List<MaintenanceTask> get upcoming {
    return allTasks
        .where((t) => t.isUpcoming)
        .toList()
      ..sort((a, b) => a.scheduledFor.compareTo(b.scheduledFor));
  }

  final List<MaintenanceTask> _completed = [];
  List<MaintenanceTask> get completed => _completed;

  void markCompleted(MaintenanceTask task) {
    task.isCompleted = true;
    _completed.add(task);
    notifyListeners();
  }
}
