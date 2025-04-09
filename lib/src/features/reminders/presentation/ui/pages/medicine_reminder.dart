



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/reminders/application/provider/reminders_providers.dart';

class MedicineReminderInfo extends ConsumerWidget {
  final int reminderId;
  const MedicineReminderInfo({required this.reminderId, super.key});

  @override
  Widget build(BuildContext context, ref) {
    final reminder = ref.watch(reminderByIdProvider(reminderId));

    final medicine = reminder.medicineReminder!;

    final name = medicine.medicineName;
    final strength = '${medicine.strength} ${medicine.unit.units}';
    final frequency = medicine.frequency.name;
    final scheduledTime = medicine.scheduledTime;
    final pattern = medicine.reminderPattern.pattern;
    final days = medicine.reminderPattern.daysOfWeek;
    final interval = medicine.reminderPattern.intervalDays;
    final notes = medicine.note;
    final img = medicine.attachment;



    return const Placeholder();
  }
}
