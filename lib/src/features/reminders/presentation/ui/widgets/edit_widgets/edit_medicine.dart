



import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/features/reminders/application/controller/add_medicine_controller.dart';
import 'package:ministry/src/features/reminders/application/controller/medicine_image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../domain/model/reminder_model.dart';

Future<void> editMedicineReminder(WidgetRef ref, ReminderModel reminder) async {

  // ref.invalidate(addMedicineController);
  // ref.invalidate(medImageProvider);
  
  final medController = ref.watch(addMedicineController);
  final medNotifier = ref.watch(addMedicineController.notifier);
  
  final medicine = reminder.medicineReminder!;
  
  final scheduledTime = medicine.scheduledTime.first;

  medNotifier.changeReminderId(medicine.id);
  
  medController.medName.text = medicine.medicineName;

  medController.startDate.text = DateFormat('yyyy-MM-dd').format(medicine.startDate);
  medController.medDuration.text = medicine.totalDays.toString();
  medController.changeFrequency(medicine.frequency.id);
  medController.time.text = DateFormat('HH:mm a').format(scheduledTime);
  medNotifier.updateSchedule(medicine.frequency.id, scheduledTime);
  medNotifier.changeMealType(medicine.meal.id);
  
  if(medicine.attachment != null) {

    File image = await uint8ListToFile(medicine.attachment!, medicine.medicineName);

    ref.read(medImageProvider.notifier).isImage(image: image);
  }

  if(medicine.note != null) medController.notes.text = medicine.note!;

  medNotifier.changePattern(medicine.reminderPattern.id);

  if(medicine.reminderPattern.id == 3) medController.interval.text = medicine.reminderPattern.intervalDays!.toString();

  if(medicine.reminderPattern.id == 2){
    for(String day in medicine.reminderPattern.daysOfWeek!){
      medNotifier.updateDaysList(day.toLowerCase());
    }
  }

  medNotifier.changeRouteType(medicine.route.id);

  medController.strengthController.text = medicine.strength.toString();
  medNotifier.changeUnit(medicine.unit.unitId);



  
  
}


Future<File> uint8ListToFile(Uint8List data, String fileName) async {
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/$fileName');
  return await file.writeAsBytes(data);
}