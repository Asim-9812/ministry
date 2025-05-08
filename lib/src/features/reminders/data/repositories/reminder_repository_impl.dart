




import 'package:hive/hive.dart';
import 'package:ministry/src/core/controllers/notification_controller.dart';
import 'package:ministry/src/features/reminders/domain/model/general_reminder_model.dart';
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
  ReminderModel fetchReminderById({required int reminderId}) {
    final medicineHiveBox = Hive.box<ReminderModel>('reminders');
    final reminder = medicineHiveBox.get('$reminderId');
    return reminder!;
  }

  @override
  Future<bool> delMedReminder({required int reminderId}) async {
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

  @override
  Future<bool> delGenReminder({required int reminderId}) async {
    try{
      final reminderBox = Hive.box<ReminderModel>('reminders');
      await reminderBox.delete('$reminderId');
      final notificationId = (reminderId);
      await NotificationController.delNotification(id: notificationId);
      String uniqueName = '2-$reminderId';
      await Workmanager().cancelByUniqueName(uniqueName);
      return true;
    }on HiveError catch(e){
      print(e);
      throw Exception('Unable to delete at this moment.');
    }
  }



  @override
  Future<bool> addMedicineReminder({required MedicineReminderModel medicine}) async {
    try{
      print('adding was executed');
      final reminderBox = Hive.box<ReminderModel>('reminders');
      final reminder = ReminderModel(
          reminderId: medicine.id,
          reminderType: 1,
        medicineReminder: medicine
      );


      String taskName = medicine.medicineName;

      String uniqueName = '1-${medicine.id}';

      Map<String, dynamic> inputData = {
        'reminderId' : reminder.reminderId,
        'reminderType' : reminder.reminderType,
        'title' : medicine.medicineName,
        'body' : 'Time for your medicine. ${medicine.strength}${medicine.unit.units} ${medicine.meal.name}',
        'dateList' : medicine.dateList.map((e)=>e.toString()).toList()
      };

      Constraints constraints =Constraints(
        networkType: NetworkType.not_required,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false,
      );

      await Workmanager().registerPeriodicTask(uniqueName, taskName, inputData: inputData,constraints: constraints,frequency: Duration(hours: 4),existingWorkPolicy: ExistingWorkPolicy.update);

      await reminderBox.put('${medicine.id}', reminder);

      print('workmanager executed');

      return true;

    }on HiveError catch(e){
      print(e);
      throw Exception('Unable to set reminder.');
    }catch(e){
      print(e);
      throw Exception('Unable to set reminder.');
    }
  }



  @override
  Future<bool> addGeneralReminder({required GeneralReminderModel generalReminder}) async {
    try{
      print('adding was executed');
      final reminderBox = Hive.box<ReminderModel>('reminders');
      final reminder = ReminderModel(
          reminderId: generalReminder.id,
          reminderType: 2,
          generalReminder: generalReminder
      );


      String taskName = generalReminder.title;

      String uniqueName = '1-${generalReminder.id}';


      Map<String, dynamic> inputData = {
        'reminderId' : reminder.reminderId,
        'reminderType' : reminder.reminderType,
        'title' : generalReminder.title,
        'body' : generalReminder.description ?? '',
        'startDate' : generalReminder.startDate.toIso8601String(),
        'patternId' : generalReminder.pattern.id,
        'daysList' : generalReminder.pattern.daysOfWeek ?? ''
      };

      print(generalReminder.startDate.toIso8601String());

      final duration = generalReminder.pattern.id != 4 ? Duration(hours: 24) : Duration(days: generalReminder.pattern.intervalDays!);

      Constraints constraints =Constraints(
        networkType: NetworkType.not_required,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiresStorageNotLow: false,
      );

      await Workmanager().registerPeriodicTask(uniqueName, taskName, inputData: inputData,constraints: constraints,frequency: duration,existingWorkPolicy: ExistingWorkPolicy.update);

      await reminderBox.put('${generalReminder.id}', reminder);

      print('workmanager executed');

      return true;

    }on HiveError catch(e){
      print(e);
      throw Exception('Unable to set reminder.');
    }catch(e){
      print(e);
      throw Exception('Unable to set reminder.');
    }
  }




}