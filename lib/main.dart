import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ministry/src/features/old_reminder/notification_controllers/notification_controller.dart';
import 'package:ministry/src/features/old_reminder/reminders/general/domain/model/general_model.dart' as oldGen;
import 'package:ministry/src/features/old_reminder/reminders/medicine/domain/model/medicine_model.dart' as oldMed;
import 'package:workmanager/workmanager.dart';
import 'src/app/my_app.dart';
import 'src/features/old_documents/domain/model/patient_document_model.dart' as oldDoc;
import 'src/features/status_page/domain/model/user_model.dart';



@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await NotificationController.initializeLocalNotifications();
    await NotificationController.initializeIsolateReceivePort();
    await NotificationController.startListeningNotificationEvents();
    try{
      if(inputData != null){
        if(inputData['reminderTypeId'] == 1){
          await NotificationController.scheduleMedicineNotifications(allData: inputData);
          return Future.value(true);
        }
        else if(inputData['reminderTypeId'] == 2){
          await NotificationController.scheduleGeneralNotifications(allData: inputData);
          return Future.value(true);
        }
        else if(inputData['reminderTypeId'] == 3){
          await NotificationController.scheduleTaskNotifications(allData: inputData);
          return Future.value(true);
        }
        // else if(inputData['reminderTypeId'] == 4){
        //   await newBgNotifications(data: inputData);
        //   return Future.value(true);
        // }
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



void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await NotificationController.initializeLocalNotifications();
  await NotificationController.initializeIsolateReceivePort();

  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode: false // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );



  Hive.registerAdapter(UserModelAdapter()); //typeid 0

  Hive.registerAdapter<oldDoc.PatientDocumentModel>(oldDoc.PatientDocumentModelAdapter()); // typeId 12

  ///reminder....  // typeId (40 & 41) & (30 - 35)
  Hive.registerAdapter<oldMed.MedicineModel>(oldMed.MedicineModelAdapter());
  Hive.registerAdapter<oldMed.MedicineRoute>(oldMed.MedicineRouteAdapter());
  Hive.registerAdapter<oldMed.MedicineUnit>(oldMed.MedicineUnitAdapter());
  Hive.registerAdapter<oldMed.Frequency>(oldMed.FrequencyAdapter());
  Hive.registerAdapter<oldMed.ReminderPattern>(oldMed.ReminderPatternAdapter());
  Hive.registerAdapter<oldMed.Meal>(oldMed.MealAdapter());
  Hive.registerAdapter<oldGen.GeneralModel>(oldGen.GeneralModelAdapter());
  Hive.registerAdapter<oldGen.RemindBefore>(oldGen.RemindBeforeAdapter());
  ///reminder end ....


  await Hive.initFlutter();
  final userBox = await Hive.openBox<UserModel>('users');
  await Hive.openBox<oldMed.MedicineModel>('medicines');
  await Hive.openBox<oldGen.GeneralModel>('generals');
  await Hive.openBox<oldDoc.PatientDocumentModel>('patientDocs');


  runApp(
      ProviderScope(
        observers: [

        ],
        child: const MyApp()
      )
  );
}

