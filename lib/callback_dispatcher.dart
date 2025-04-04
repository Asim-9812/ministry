//
// import 'package:workmanager/workmanager.dart';
//
// import 'src/core/controllers/notification_controller.dart';
//
// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     await NotificationController.initialize();
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
//
