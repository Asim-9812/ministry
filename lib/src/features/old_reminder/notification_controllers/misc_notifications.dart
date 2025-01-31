//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:intl/intl.dart';
// import '../../../features/global/notifications/domain/model/misc_notification_model.dart';
//
// import '../../../features/global/notifications/domain/service/notice_services.dart';
// import '../../api/api.dart';
// import '../../models/common_state.dart';
//
//
//
//
// final notificationProvider = FutureProvider.family((ref,Map<String,dynamic> data) => newNotifications(ref:ref,data: data));
//
// final notifierProvider = StateProvider.family((ref,String code) => _notifier(code: code));
//
//
//
// Future<void> newNotifications({required FutureProviderRef ref,required Map<String, dynamic> data}) async {
//
//   String code = data['code'];
//   String token = data['token'];
//   String orgId = data['orgId'];
//
//   String now = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 2)));
//   String from = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 5)));
//
//
//   final miscNotificationBox = Hive.box<MiscNotificationModel>('misc');
//
//   dio.options.headers['Authorization'] = 'Bearer $token';
//
//   while (true) {
//
//     _labReport(ref: ref,box: miscNotificationBox,code: code, from: from, now: now);
//     // _opdReport(ref: ref,box: miscNotificationBox,code: code,orgId: orgId ,from: from, now: now);
//     _request(ref: ref, box: miscNotificationBox, code: code);
//
//     ref.refresh(noticeProvider(Tuple2(code, token)));
//     ref.refresh(notifierProvider(code));
//
//
//
//
//     // Wait for a while before fetching again
//     await Future.delayed(Duration(seconds: 5));
//
//   }
// }
//
// void _labReport({required FutureProviderRef ref,required Box box,required String code, required String from, required String now}) async {
//
//   String url = '${Api.getLabReport}/$code/$from/$now';
//   final response = await dio.get(url);
//   if (response.statusCode == 200) {
//     List<String> data = (response.data['result'] as List<dynamic>).map((e) => e['id'].toString()).toList();
//
//     List<dynamic> reports = response.data['result'] as List<dynamic>;
//
//
//     if(reports.any((element) {
//       DateTime currentDate = DateTime.now().subtract(Duration(seconds: 5));
//       DateTime reportDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(element['entryDate']);
//       if(reportDate.isAfter(currentDate)){
//         MiscNotificationModel misc = MiscNotificationModel(userId: code,date: element['entryDate'].toString(), desc: 'Your report is ready.', id: element['id'], title: 'Lab Report', typeId: 1, isSeen: false);
//         if(!box.values.any((e) => e.id == element['id'] && e.typeId == 1)){
//           box.add(misc);
//         }
//         ref.refresh(notifierProvider(code));
//         return true;
//       }
//       else{
//         return false;
//       }
//     })){
//       AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: 05,
//           channelKey: 'misc_alerts',
//           title: 'Lab Report',
//           body: 'Your report is ready.',
//           payload: {
//             'reminderTypeId' : '3'
//           }
//         ),
//       );
//
//     }
//   }
//
// }
//
// void _opdReport({required FutureProviderRef ref,required Box box,required String code,required String orgId, required String from, required String now}) async {
//   // Replace with your API endpoint
//   String url = '${Api.getOPDList}/$code/$orgId';
//
//   final response = await dio.get(url);
//
//   if (response.statusCode == 200) {
//     List<String> data = (response.data['result'] as List<dynamic>).map((e) => e['id'].toString()).toList();
//
//     List<dynamic> reports = response.data['result'] as List<dynamic>;
//
//
//     if(reports.any((element) {
//       DateTime currentDate = DateTime.now().subtract(Duration(seconds: 5));
//       DateTime reportDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(element['entryDate']);
//       if(reportDate.isAfter(currentDate)){
//         MiscNotificationModel misc = MiscNotificationModel(userId: code,date: element['entryDate'].toString(), desc: 'Your report is ready.', id: element['id'], title: 'OPD Report', typeId: 3, isSeen: false);
//         if(!box.values.any((e) => e.id == element['id'] && e.typeId == 1)){
//           box.add(misc);
//         }
//         ref.refresh(notifierProvider(code));
//         return true;
//       }
//       else{
//         return false;
//       }
//     })){
//       AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: 06,
//           channelKey: 'misc_alerts',
//           title: 'OPD Report',
//           body: 'Your report is ready.',
//           payload: {
//             'reminderTypeId' : '3'
//           }
//         ),
//       );
//
//     }
//   }
//
// }
//
// void _request({required FutureProviderRef ref,required Box box,required String code}) async {
//
//
//   String memName = '';
//   // Replace with your API endpoint
//   String url = '${Api.requestList}/$code';
//
//   final response = await dio.get(url);
//
//   if (response.statusCode == 200) {
//
//     List<dynamic> reports = response.data['result'] as List<dynamic>;
//
//
//     if(reports.any((element) {
//       DateTime currentDate = DateTime.now().subtract(Duration(seconds: 5));
//       DateTime reportDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(element['entryDate']);
//       String name = '${element['firstName']} ${element['lastName']}';
//       memName = name;
//       if(reportDate.isAfter(currentDate)){
//         MiscNotificationModel misc = MiscNotificationModel(userId: code,date: element['entryDate'].toString(), desc: 'sent you a friend request.', id: element['id'], title: name, typeId: 2, isSeen: false);
//         if(!box.values.any((e) => e.id == element['id'] && e.typeId == 2)){
//           box.add(misc);
//         }
//
//         ref.refresh(notifierProvider(code));
//         return true;
//       }
//       else{
//         return false;
//       }
//     })){
//       AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: 07,
//           channelKey: 'misc_alerts',
//           title: 'Family Request',
//           body: '$memName sent you a request.',
//           payload: {
//             'reminderTypeId' : '3'
//           }
//         ),
//       );
//
//     }
//   }
// }
//
// List<MiscNotificationModel> _notifier({required String code}) {
//
//   final miscNotifications = Hive.box<MiscNotificationModel>('misc').values.where((element) => element.userId == code && element.isSeen == false).toList();
//
//   if (miscNotifications.isNotEmpty) {
//
//     return miscNotifications;
//
//   }
//   else{
//     return [];
//   }
// }
//
// void notifierState({required MiscNotificationModel data}) {
//
//   final miscNotificationBox = Hive.box<MiscNotificationModel>('misc');
//   final miscNotificationList = Hive.box<MiscNotificationModel>('misc').values.toList();
//
//   final index = miscNotificationList.indexWhere((element) => element.id == data.id);
//
//   final newData = MiscNotificationModel(
//       date: data.date,
//       desc: data.desc,
//       id: data.id,
//       title: data.title,
//       typeId: data.typeId,
//       isSeen: true,
//       userId: data.userId
//   );
//
//   miscNotificationBox.putAt(index, newData);
//
// }
//
// void notifierDel({required MiscNotificationModel data}) {
//
//   final miscNotificationBox = Hive.box<MiscNotificationModel>('misc');
//   final miscNotificationList = Hive.box<MiscNotificationModel>('misc').values.toList();
//
//   final index = miscNotificationList.indexWhere((element) => element.id == data.id && element.typeId == 2);
//
//
//
//   miscNotificationBox.deleteAt(index);
//
// }
//
//
//
//
//
