


import 'package:ministry/src/features/reminders/domain/model/general_reminder_model.dart';

import '../../domain/model/medicine_reminder_model.dart';
import '../../domain/model/reminder_model.dart';

abstract class ReminderRepository{

  List<ReminderModel> fetchAllReminder({int? type});
  ReminderModel fetchReminderById({required int reminderId});
  Future<bool> addMedicineReminder({required MedicineReminderModel medicine});
  Future<bool> addGeneralReminder({required GeneralReminderModel generalReminder});
  Future<bool> delMedReminder({required int reminderId});
  Future<bool> delGenReminder({required int reminderId});


}