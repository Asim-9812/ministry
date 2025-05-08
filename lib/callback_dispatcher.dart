
import 'package:ministry/src/core/controllers/general_notification_controller.dart';
import 'package:ministry/src/core/controllers/medicine_notification_controller.dart';
import 'package:workmanager/workmanager.dart';

import 'src/core/controllers/notification_controller.dart';


//workmanagers code doesn't update the app with the changes in code. Solution : reinstalling the app will apply the changes in the code too.

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {

    await NotificationController.initialize();
    await NotificationController.startListeningNotificationEvents();

    // print('Executing background task: $task');
    // print('Input data: $inputData');

    try {

      if (inputData != null) {

        if (inputData['reminderType'] == 1) {
          // print('Triggering Medicine Notification');
          await MedicineNotificationController.setScheduledNotification(inputData: inputData);
          return Future.value(true);
        }
        else if(inputData['reminderType'] == 2){
          await GeneralNotificationController.setScheduledNotification(inputData: inputData);
          return Future.value(true);
        }
        else {
          // print('Unsupported reminder type');
          return Future.value(false);
        }
      } else {
        // print('Input data is null');
        return Future.value(false);
      }
    } catch (e, stack) {
      print('Exception occurred: $e');
      print(stack);
      return Future.value(false);
    }

  });
}

