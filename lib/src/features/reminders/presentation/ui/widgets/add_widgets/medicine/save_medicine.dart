

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ministry/src/features/reminders/application/controller/medicine_image_picker.dart';
import 'package:ministry/src/features/reminders/application/provider/reminders_providers.dart';

import '../../../../../../../core/resources/color_manager.dart';
import '../../../../../../../core/resources/font_manager.dart';
import '../../../../../../../core/utils/toaster.dart';
import '../../../../../application/controller/add_medicine_controller.dart';
import '../../../../../application/controller/reminder_notifier.dart';
import '../../../../../data/medicine_data/frequency_list.dart';
import '../../../../../data/medicine_data/meal_list.dart';
import '../../../../../data/medicine_data/pattern_list.dart';
import '../../../../../data/medicine_data/route_list.dart';
import '../../../../../data/medicine_data/unit_list.dart';
import '../../../../../domain/model/medicine_reminder_model.dart';

class SaveMedicineButton extends ConsumerWidget {
  const SaveMedicineButton({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final medInfo = ref.watch(addMedicineController);
    final formKey = medInfo.formKey;
    final remId = medInfo.reminderId;
    final mealId = medInfo.mealId;
    final routeId = medInfo.routeId;
    final unitId = medInfo.unitId;
    final frequencyId = medInfo.frequencyId;
    final patternId = medInfo.patternId;
    final medState = ref.watch(reminderNotifier);
    final medNotifier = ref.read(reminderNotifier.notifier);
    final medImage = ref.watch(medImageProvider);
    final note = medInfo.notes;
    return Row(
      children: [
        Expanded(
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: MyColors.primary,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                )
              ),
    onPressed: () async {
      if (!formKey.currentState!.validate()) {
        Toaster.error('Please fill all the necessary fields.');
        return;
      }

      final errors = <String, VoidCallback>{
        if (routeId == 0) 'Route is required.': () => ref.read(addMedicineController.notifier).routeHasError(true),
        if (unitId == 0) 'Unit is required.': () => ref.read(addMedicineController.notifier).unitHasError(true),
        if (frequencyId == 0) 'Frequency is required.': () => ref.read(addMedicineController.notifier).frequencyHasError('Frequency is required.'),
        if (patternId == 0) 'Pattern is required.': () => ref.read(addMedicineController.notifier).patternHasError('Pattern is required.'),
      };

      if (errors.isNotEmpty) {
        errors.forEach((_, callback) => callback()); // Trigger all error handlers
        Toaster.error('Please fill all the necessary fields.');
        return;
      }

      // Proceed if all validations pass

      final medId = remId ?? Random().nextInt(100) + 1000;
      final medicineName = medInfo.medName.text.trim();
      final route = medicineRouteList.singleWhere((e)=>e.id == routeId);
      final strength = double.parse(medInfo.strengthController.text.trim());
      final unit = medicineUnitList.singleWhere((e)=>e.unitId == unitId);
      final frequency = frequencyList.singleWhere((e)=>e.id == frequencyId);
      final scheduledTime = medInfo.scheduledTimeList;
      final totalDays = int.parse(medInfo.medDuration.text.trim());
      final startDate = DateTime.parse(medInfo.startDate.text.trim());
      final endDate = startDate.add(Duration(days: totalDays-1));
      final meal = mealList.singleWhere((e)=>e.id == mealId);


      // For list of dates from startDate to endDate
      List<DateTime> dateList = [];
      for(int i = 0; i < totalDays; i++){
        final dateTime = startDate.add(Duration(days: i));
        for(int j = 0; j < scheduledTime.length; j++){
          final scheduledDateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, scheduledTime[j].hour, scheduledTime[j].minute);
          dateList.add(scheduledDateTime);
        }
      }

      final pattern = patternList.singleWhere((e)=>e.id == patternId);
      final reminderPattern = ReminderPattern(
          id: pattern.id,
          pattern: pattern.pattern,
          intervalDays: patternId == 3 ? int.parse(medInfo.interval.text.trim()) : null,
          daysOfWeek: patternId == 2 ? medInfo.selectedDaysOfWeek : null
      );

      final medicine = MedicineReminderModel(
          id: medId,
          medicineName: medicineName,
          route: route,
          strength: strength,
          unit: unit,
          frequency: frequency,
          scheduledTime: scheduledTime,
          totalDays: totalDays,
          startDate: startDate,
          endDate: endDate,
          dateList: dateList,
          meal: meal,
          reminderPattern: reminderPattern,
          attachment:await medImage?.readAsBytes(),
          note: note.text

      );

      // print(medicine.scheduledTime);

      await medNotifier.addMedicineReminder(medicine: medicine).whenComplete((){
        ref.refresh(reminderProvider);
        ref.refresh(reminderByIdProvider(medId));
        Navigator.pop(context);
      });


    },

    child: medState.isLoading
            ? SpinKitDualRing(color: MyColors.white,size: 16,)
            :Text('Save',style: wh2,)
          ),
        ),
      ],
    );
  }
}
