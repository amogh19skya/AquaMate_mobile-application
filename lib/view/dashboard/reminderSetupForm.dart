import 'package:flutter/material.dart';

import '../../services/notification_service.dart';

// Assuming you'll eventually use a controller for state management (e.g., GetX, Provider, BLoC)
// For simplicity, we'll use a StatefulWidget for now.

// FIX: Class name changed to align with the route and file name
class ReminderSetupForm extends StatefulWidget {
  const ReminderSetupForm({super.key});

  @override
  State<ReminderSetupForm> createState() => _ReminderSetupFormState();
}

// FIX: State class name updated
class _ReminderSetupFormState extends State<ReminderSetupForm> {
  // 1. State variables to hold the selected reminder type and date/time
  String? _selectedTask;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _tankNameController = TextEditingController();

  // Helper list for the task buttons
  final List<String> _tasks = [
    'Fish Feed',
    'Water Change',
    'Tank Cleaning',
    'Filter Wash',
  ];

  // Helper method to show the Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Helper method to show the Time Picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reminder Setup', style: TextStyle(fontWeight: FontWeight.bold)), // Changed title slightly
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- 1. Tank Name Input ---
            _buildInputContainer(
              child: TextField(
                controller: _tankNameController,
                decoration: const InputDecoration(
                  hintText: 'Tank Name',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // --- 2. Task Selection Buttons ---
            ..._tasks.map((task) => Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: _buildTaskButton(task),
            )).toList(),

            // --- 3. Date Picker ---
            GestureDetector(
              onTap: () => _selectDate(context),
              child: _buildInputContainer(
                child: Text(
                  _selectedDate == null
                      ? 'Date picker'
                      : 'Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                  style: TextStyle(
                    color: _selectedDate == null ? Colors.grey[600] : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // --- 4. Time Picker ---
            GestureDetector(
              onTap: () => _selectTime(context),
              child: _buildInputContainer(
                child: Text(
                  _selectedTime == null
                      ? 'Time'
                      : 'Time: ${_selectedTime!.format(context)}',
                  style: TextStyle(
                    color: _selectedTime == null ? Colors.grey[600] : Colors.black,
                  ),
                ),
              ),
            ),

            const Spacer(),

            // --- 5. Action Buttons (Cancel and Set) ---
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Logic for Cancel (e.g., Navigator.pop(context))
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text('Cancel', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
                // Set Button
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement the save logic by calling ReminderController
                        void _saveReminder() async {
                          if (_selectedTask == null ||
                              _selectedDate == null ||
                              _selectedTime == null ||
                              _tankNameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please fill out all fields!')),
                            );
                            return;
                          }

                          final DateTime finalScheduledDate = DateTime(
                            _selectedDate!.year,
                            _selectedDate!.month,
                            _selectedDate!.day,
                            _selectedTime!.hour,
                            _selectedTime!.minute,
                          );

                          // 🔥 Schedule the notification
                          await NotificationService.scheduleNotification(
                            id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
                            title: _selectedTask!,
                            body: 'Tank: ${_tankNameController.text}',
                            scheduledDate: finalScheduledDate,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Reminder Set Successfully!')),
                          );

                          Navigator.pop(context);
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF67D7A3), // A friendly green color
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: const Text('Set', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget builder for the common input/button style
  Widget _buildInputContainer({required Widget child}) {
    return Container(
      height: 60,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }

  // Widget builder for the Task Radio Buttons
  Widget _buildTaskButton(String task) {
    bool isSelected = _selectedTask == task;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTask = task;
        });
      },
      child: Container(
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF67D7A3).withOpacity(0.2) : Colors.grey[200],
          borderRadius: BorderRadius.circular(15),
          border: isSelected ? Border.all(color: const Color(0xFF67D7A3), width: 2) : null,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          task,
          style: TextStyle(
            color: isSelected ? const Color(0xFF67D7A3) : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Placeholder for the save function that will call the controller
  void _saveReminder() {
    // ... (rest of the save logic remains the same)
    if (_selectedTask == null || _selectedDate == null || _selectedTime == null || _tankNameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields!')),
      );
      return;
    }

    final DateTime finalScheduledDate = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _selectedTime!.hour,
      _selectedTime!.minute,
    );

    print('--- New Reminder Data ---');
    print('Tank Name: ${_tankNameController.text}');
    print('Task: $_selectedTask');
    print('Scheduled For: $finalScheduledDate');
    print('-------------------------');
  }
}