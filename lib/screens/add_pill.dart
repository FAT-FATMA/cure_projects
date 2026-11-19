import 'dart:developer';

import 'package:cure/buisness/medicine/medicine.dart';
import 'package:cure/buisness/medicine/medicine_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddPill extends ConsumerStatefulWidget {
  const AddPill({super.key});

  @override
  ConsumerState<AddPill> createState() => _AddPillState();
}

class _AddPillState extends ConsumerState<AddPill> {
  final TextEditingController _medicineController = TextEditingController();
  final TextEditingController _doseController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _selectedFrequency = 'Daily';
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _medicineController.dispose();
    _doseController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        final isoDate = DateFormat('yyyy-MM-dd').format(picked);
        if (isStartDate) {
          _startDateController.text = isoDate;
        } else {
          _endDateController.text = isoDate;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  DateTime? _parseDate(String dateText) {
    try {
      return DateFormat('yyyy-MM-dd').parse(dateText);
    } catch (e) {
      return null;
    }
  }

  DateTime? calculateNextDate() {
    DateTime? startDate = _parseDate(_startDateController.text);
    startDate = DateTime(
      startDate!.year,
      startDate.month,
      startDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
    log('Start Date: $startDate');
    final now = DateTime.now();

    final difference = startDate.difference(now);
    log('difference: $difference');
    if (difference.isNegative) {
      switch (_selectedFrequency) {
        case 'Daily':
          return startDate.add(const Duration(days: 1));
        case 'Weekly':
          return startDate.add(const Duration(days: 7));
        case 'Monthly':
          return DateTime(startDate.year, startDate.month + 1, startDate.day);
        default:
          return null;
      }
    }
    return startDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Medicine')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _medicineController,
              decoration: InputDecoration(
                labelText: 'Medicine Name',
                fillColor: const Color.fromARGB(255, 197, 219, 255),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _doseController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Dose',
                fillColor: const Color.fromARGB(255, 197, 219, 255),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildDateField(context, true),
            const SizedBox(height: 16),
            _buildDateField(context, false),
            const SizedBox(height: 16),
            _buildTimeField(context),
            const SizedBox(height: 16),
            _buildFrequencyDropdown(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveMedicine,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff1877f2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Save Medicine'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, bool isStartDate) {
    return TextField(
      controller: isStartDate ? _startDateController : _endDateController,
      decoration: InputDecoration(
        labelText:
            isStartDate ? 'Start Date (YYYY-MM-DD)' : 'End Date (YYYY-MM-DD)',
        fillColor: const Color.fromARGB(255, 197, 219, 255),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context, isStartDate),
        ),
      ),
      readOnly: true,
      onTap: () => _selectDate(context, isStartDate),
    );
  }

  Widget _buildTimeField(BuildContext context) {
    return TextField(
      controller: _timeController,
      decoration: InputDecoration(
        labelText: 'Time',
        fillColor: const Color.fromARGB(255, 197, 219, 255),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: Icon(Icons.access_time),
      ),
      readOnly: true,
      onTap: () => _selectTime(context),
    );
  }

  Widget _buildFrequencyDropdown() {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: 'Frequency',
        fillColor: const Color.fromARGB(255, 197, 219, 255),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedFrequency,
          isExpanded: true,
          items: const [
            DropdownMenuItem(value: 'Daily', child: Text('Daily')),
            DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
            DropdownMenuItem(value: 'Monthly', child: Text('Monthly')),
          ],
          onChanged: (value) => setState(() => _selectedFrequency = value!),
        ),
      ),
    );
  }

  void _saveMedicine() {
    // Input validation
    if (_medicineController.text.isEmpty ||
        _doseController.text.isEmpty ||
        _startDateController.text.isEmpty ||
        _endDateController.text.isEmpty ||
        _timeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }

    final startDate = _parseDate(_startDateController.text);
    final endDate = _parseDate(_endDateController.text);

    if (startDate == null || endDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid date format')));
      return;
    }

    final period = endDate.difference(startDate).inDays;
    if (period <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End date must be after start date')),
      );
      return;
    }

    int dose;
    try {
      dose = int.parse(_doseController.text);
      if (dose <= 0) throw Exception();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dose must be a positive number')),
      );
      return;
    }

    final newMedicine = Medicine(
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      id:
          ref.read(pillProvider.notifier).state.isEmpty
              ? 1
              // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
              : ref.read(pillProvider.notifier).state.last.id + 1,
      medicineName: _medicineController.text,
      dose: dose,
      frequency: _selectedFrequency,
      period: period,
      taken: 0,
      next_date: calculateNextDate(),
    );
    ref.read(pillProvider.notifier).addPill(newMedicine);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${newMedicine.medicineName} added successfully!'),
      ),
    );
  }
}
