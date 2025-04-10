import 'package:device_preview_plus/device_preview_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ministry/src/core/controllers/notification_controller.dart';
// import 'package:ministry/src/features/old_reminder/notification_controllers/notification_controller.dart';
import 'package:ministry/src/features/old_reminder/reminders/general/domain/model/general_model.dart' as oldGen;
import 'package:ministry/src/features/old_reminder/reminders/medicine/domain/model/medicine_model.dart' as oldMed;
import 'package:ministry/src/features/reminders/domain/model/general_reminder_model.dart';

import 'package:workmanager/workmanager.dart';
import 'callback_dispatcher.dart';
import 'src/app/my_app.dart';
import 'src/features/reminders/domain/model/medicine_reminder_model.dart';
import 'src/features/reminders/domain/model/notes_model.dart';
import 'src/features/reminders/domain/model/reminder_model.dart';
import 'src/features/status_page/domain/model/user_model.dart';



//
// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     await NotificationController.initializeLocalNotifications();
//     await NotificationController.initializeIsolateReceivePort();
//     await NotificationController.startListeningNotificationEvents();
//     try{
//       if(inputData != null){
//         if(inputData['reminderTypeId'] == 1){
//           await NotificationController.scheduleMedicineNotifications(allData: inputData);
//           return Future.value(true);
//         }
//         else if(inputData['reminderTypeId'] == 2){
//           await NotificationController.scheduleGeneralNotifications(allData: inputData);
//           return Future.value(true);
//         }
//         else if(inputData['reminderTypeId'] == 3){
//           await NotificationController.scheduleTaskNotifications(allData: inputData);
//           return Future.value(true);
//         }
//         // else if(inputData['reminderTypeId'] == 4){
//         //   await newBgNotifications(data: inputData);
//         //   return Future.value(true);
//         // }
//         else{
//           return Future.value(false);
//         }
//       }
//       else{
//         return Future.value(false);
//       }
//     } catch(e){
//       //print(e);
//       return Future.value(false);
//     }
//   });
// }




void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await NotificationController.initialize();
  await NotificationController.startListeningNotificationEvents();

  // await NotificationController.initializeLocalNotifications();
  // await NotificationController.initializeIsolateReceivePort();

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );



  Hive.registerAdapter(UserModelAdapter()); //typeid 0

  ///reminder....  // typeId (2 - 11)
  Hive.registerAdapter(ReminderModelAdapter()); //typeid 2
  Hive.registerAdapter(NoteModelAdapter()); //typeid 3
  Hive.registerAdapter(GeneralReminderModelAdapter()); //typeid 4
  Hive.registerAdapter(GeneralReminderPatternAdapter()); //typeid 5
  Hive.registerAdapter(MedicineReminderModelAdapter()); //typeid 6
  Hive.registerAdapter(MedicineRouteAdapter()); //typeid 7
  Hive.registerAdapter(MedicineUnitAdapter()); //typeid 8
  Hive.registerAdapter(FrequencyAdapter()); //typeid 9
  Hive.registerAdapter(MealAdapter()); //typeid 10
  Hive.registerAdapter(ReminderPatternAdapter()); //typeid 11
  ///reminder end ....


  ///old reminder....  // typeId (40 & 41) & (30 - 35)
  // Hive.registerAdapter<oldMed.MedicineModel>(oldMed.MedicineModelAdapter());
  // Hive.registerAdapter<oldMed.MedicineRoute>(oldMed.MedicineRouteAdapter());
  // Hive.registerAdapter<oldMed.MedicineUnit>(oldMed.MedicineUnitAdapter());
  // Hive.registerAdapter<oldMed.Frequency>(oldMed.FrequencyAdapter());
  // Hive.registerAdapter<oldMed.ReminderPattern>(oldMed.ReminderPatternAdapter());
  // Hive.registerAdapter<oldMed.Meal>(oldMed.MealAdapter());
  // Hive.registerAdapter<oldGen.GeneralModel>(oldGen.GeneralModelAdapter());
  // Hive.registerAdapter<oldGen.RemindBefore>(oldGen.RemindBeforeAdapter());
  ///old reminder end ....


  await Hive.initFlutter();
  await Hive.openBox<UserModel>('users');
  // await Hive.openBox<oldMed.MedicineModel>('medicines');
  // await Hive.openBox<oldGen.GeneralModel>('generals');
  await Hive.openBox<ReminderModel>('reminders');


  runApp(
      DevicePreview(
        enabled: true,
        builder:(context){
          return ProviderScope(
              observers: [
              ],
              child: const MyApp()
          );
        }
      )
  );
}

