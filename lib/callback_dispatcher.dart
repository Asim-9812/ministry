
import 'package:ministry/src/core/controllers/medicine_notification_controller.dart';
import 'package:ministry/src/features/reminders/domain/model/reminder_model.dart';
import 'package:workmanager/workmanager.dart';

import 'src/core/controllers/notification_controller.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await NotificationController.initialize();
    await NotificationController.startListeningNotificationEvents();
    try{
      if(inputData != null){
        if(inputData['reminderTypeId'] == 1){
          ReminderModel reminder = ReminderModel.fromJson(inputData);

          await MedicineNotificationController.setScheduledNotification(reminder: reminder);
          return Future.value(true);
        }
        else{
          return Future.value(false);
        }
      }
      else{
        return Future.value(false);
      }
    } catch(e){
      //print(e);
      return Future.value(false);
    }
  });
}

