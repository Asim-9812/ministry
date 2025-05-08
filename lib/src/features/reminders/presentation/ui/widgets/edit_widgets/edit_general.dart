



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/reminders/application/controller/general/add_general_controller.dart';

import '../../../../domain/model/reminder_model.dart';

Future<void> editGeneralReminder(WidgetRef ref, ReminderModel reminder) async {

  // ref.invalidate(addMedicineController);
  // ref.invalidate(medImageProvider);

  final medController = ref.watch(addGeneralController);
  final medNotifier = ref.watch(addGeneralController.notifier);

  final general = reminder.generalReminder!;



  medController.labelController.text = general.title;

  if(general.description != null && general.description!.trim().isNotEmpty){
    medController.descController.text = general.description!;
  }


  if(general.pattern.id == 4){
    medController.intervalController.text = general.pattern.intervalDays.toString();
  }

  medNotifier.changeStartDate(general.startDate);
  medNotifier.changeHour(general.startDate.hour.toString());
  medNotifier.changeMinute(general.startDate.minute.toString());
  medNotifier.changePeriod(general.startDate.hour > 12? 'PM' : 'AM');
  medNotifier.changePattern(general.pattern.id);

  if(general.pattern.id == 3){
    for(String day in general.pattern.daysOfWeek!){
      medNotifier.updateDaysList(day);
    }

  }





}