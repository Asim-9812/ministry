import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider to access AddGeneralController
final addGeneralController = ChangeNotifierProvider.autoDispose((ref) => AddGeneralController());

class AddGeneralController extends ChangeNotifier {
  final DateTime now = DateTime.now();

  // Private field for hour
  int _hour = DateTime.now().hour % 12 == 0 ? 12 : DateTime.now().hour % 12;
  int _min = DateTime.now().minute;
  String _period = DateTime.now().hour >= 12 ? 'PM' : 'AM';

  // Getters
  int get hour => _hour;
  int get min => _min;
  String get period => _period;

  // FixedExtentScrollController for hour, minute, and period lists
  late FixedExtentScrollController hourController;
  late FixedExtentScrollController minuteController;
  late FixedExtentScrollController periodController;

  // Constructor to initialize FixedExtentScrollControllers
  AddGeneralController() {
    hourController = FixedExtentScrollController();
    minuteController = FixedExtentScrollController();
    periodController = FixedExtentScrollController();

    // Initialize scroll positions based on the current time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setInitialScrollPosition();
    });
  }

  // Set initial scroll positions based on current time
  void _setInitialScrollPosition() {
    hourController.jumpTo((_hour - 1) * 40.0); // Assuming each item has height of 40.0
    minuteController.jumpTo(_min * 40.0); // Similarly for minutes
    periodController.jumpTo(_period == 'AM' ? 0.0 : 40.0); // Assuming 'AM' is at 0 and 'PM' is at 1
  }

  // Dispose controllers when not needed
  @override
  void dispose() {
    hourController.dispose();
    minuteController.dispose();
    periodController.dispose();
    super.dispose();
  }

  // Change the hour value
  void changeHour(String value) {
    final newHour = int.parse(value);
    _hour = newHour; // Update internal state
    notifyListeners(); // Notify listeners to update UI
  }

  // Change the minute value
  void changeMinute(String value) {
    final newMinute = int.parse(value);
    _min = newMinute;
    notifyListeners();
  }

  // Change the period value (AM/PM)
  void changePeriod(String value) {
    _period = value;
    notifyListeners();
  }
}
