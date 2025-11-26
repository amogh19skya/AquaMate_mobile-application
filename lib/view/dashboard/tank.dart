// lib/view/dashboard/tank.dart

import 'package:flutter/material.dart';
import 'package:aqua_mate/model/tank_model.dart';
import 'package:aqua_mate/controller/tank_controller.dart';

class TankFormScreen extends StatefulWidget {
  const TankFormScreen({super.key});

  @override
  _TankFormScreenState createState() => _TankFormScreenState();
}

class _TankFormScreenState extends State<TankFormScreen> {
  final _formKey = GlobalKey<FormState>();
  // Controller for managing tank data
  late final TankController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TankController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _tankName = '';
  String _capacity = '';
  String _planted = '';
  String _numberOfFishes = '';
  String _dimension = '';

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create the model object from the form data
      final newTank = Tank(
        name: _tankName,
        capacity: _capacity,
        planted: _planted,
        numberOfFishes: _numberOfFishes,
        dimension: _dimension,
      );

      // Pass the model object to the controller for handling
      _controller.saveTank(newTank);

      // Optionally, reset the form after successful submission
      _formKey.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Tank'),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          // Constrain width for a pleasant desktop/web experience
          constraints: const BoxConstraints(maxWidth: 450),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 15,
                  offset: Offset(0, 5)
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Tank Setup',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 25),
                _buildFormField(
                  labelText: 'Tank Name',
                  onSaved: (value) => _tankName = value!,
                  keyboardType: TextInputType.text,
                ),
                _buildFormField(
                  labelText: 'Capacity (Liters)',
                  onSaved: (value) => _capacity = value!,
                  keyboardType: TextInputType.number,
                ),
                _buildFormField(
                  labelText: 'Planted (Yes/No)',
                  onSaved: (value) => _planted = value!,
                  keyboardType: TextInputType.text,
                ),
                _buildFormField(
                  labelText: 'No. of Fishes',
                  onSaved: (value) => _numberOfFishes = value!,
                  keyboardType: TextInputType.number,
                ),
                _buildFormField(
                  labelText: 'Dimension (LxWxH cm)',
                  onSaved: (value) => _dimension = value!,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for consistent text field styling
  Widget _buildFormField({
    required String labelText,
    required FormFieldSetter<String> onSaved,
    required TextInputType keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey[600]),
          filled: true,
          fillColor: Colors.grey[50],
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.teal, width: 2),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter the $labelText';
          }
          return null;
        },
        onSaved: onSaved,
      ),
    );
  }
}