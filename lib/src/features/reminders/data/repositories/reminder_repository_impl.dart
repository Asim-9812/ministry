




import 'package:hive/hive.dart';
import 'package:ministry/src/core/controllers/notification_controller.dart';
import 'package:workmanager/workmanager.dart';

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

      String taskName = medicine.medicineName;

      String uniqueName = '1-${medicine.id}';

      Constraints constraints =Constraints(
        networkType: NetworkType.not_required,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false,
      );

      await Workmanager().registerPeriodicTask(uniqueName, taskName, inputData: reminder.toJson(),constraints: constraints,frequency: Duration(hours: 4));

      print('executed');

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
      for(int i =0; i<4; i++){
        final notificationId = (reminderId * 1000) + i;
        await NotificationController.delNotification(id: notificationId);
      }
      String uniqueName = '1-$reminderId';
      await Workmanager().cancelByUniqueName(uniqueName);
      return true;
    }on HiveError catch(e){
      print(e);
      throw Exception('Unable to delete at this moment.');
    }
  }


}