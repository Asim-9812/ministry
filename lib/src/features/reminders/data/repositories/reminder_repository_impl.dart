




import 'package:hive/hive.dart';

import '../../domain/model/medicine_reminder_model.dart';
import '../../domain/model/reminder_model.dart';
import 'reminder_repository.dart';

class ReminderRepositoryImpl extends ReminderRepository{

  @override
  List<ReminderModel> fetchAllReminder({int? type}) {
    final reminders = Hive.box<ReminderModel>('reminders').values.toList();
    if(type != null){
      final filteredReminders = reminders.where((e)=>e.reminderType == type).toList();
      return filteredReminders;
    }
    else{
      return reminders;
    }
  }

  @override
  Future<bool> addMedicineReminder({required MedicineReminderModel medicine}) async {
    try{
      final reminderBox = Hive.box<ReminderModel>('reminders');
      final reminder = ReminderModel(
          reminderId: medicine.id,
          reminderType: 1,
        medicineReminder: medicine
      );
      await reminderBox.put('${medicine.id}', reminder);
      return true;

    }on HiveError catch(e){
      print(e);
      throw Exception('Unable to set reminder.');
    }
  }

  @override
  Future<bool> delReminder({required int reminderId}) async {
    try{
      final reminderBox = Hive.box<ReminderModel>('reminders');
      await reminderBox.delete('$reminderId');
      return true;
    }on HiveError catch(e){
      print(e);
      throw Exception('Unable to delete at this moment.');
    }
  }


}