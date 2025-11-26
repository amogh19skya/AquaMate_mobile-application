// maintenance_model.dart

class MaintenanceTask {
  final String tankName;
  final String task;
  final DateTime scheduledFor;
  bool isCompleted;

  MaintenanceTask({
    required this.tankName,
    required this.task,
    required this.scheduledFor,
    this.isCompleted = false,
  });

  // Helper: determine if overdue
  bool get isOverdue {
    return !isCompleted && scheduledFor.isBefore(DateTime.now());
  }

  // Helper: determine if upcoming
  bool get isUpcoming {
    return !isCompleted && scheduledFor.isAfter(DateTime.now());
  }
}
