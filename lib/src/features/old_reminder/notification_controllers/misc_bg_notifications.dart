//
// import 'dart:math';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:dio/dio.dart';
// import 'package:intl/intl.dart';
// import '../../api/api.dart';
//
//
//
// /// NOTE: NOTIFICATIONS FROM HERE WILL TAKE 15 MINUTES SINCE WORK MANAGER WORKS IN THE BACKGROUND EVERY 15 MINUTES
//
//
// Future<void> newBgNotifications({required Map<String, dynamic> data}) async {
//
//   String code = data['code'];
//   String token = data['token'];
//   String orgId = data['orgId'];
//
//   String now = DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 2)));
//   String from = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 5)));
//
//   dio.options.headers['Authorization'] = 'Bearer $token';
//
//     await _labReport(code: code,from: from, now: now);
//     // _opdReport(orgId:orgId,code: code);
//     await _request(code: code);
//
//     print('executed');
//
// }
//
// Future<void> _labReport({required String code, required String from, required String now}) async {
//   // Replace with your API endpoint
//   String url = '${Api.getLabReport}/$code/$from/$now';
//
//   try{
//     final response = await dio.get(url,
//         options: Options(
//             sendTimeout: Duration(seconds: 10),
//             receiveTimeout: Duration(seconds: 10)
//         )
//     );
//
//     if (response.statusCode == 200) {
//       print('lab executed');
//
//       List<String> data = (response.data['result'] as List<dynamic>).map((e) => e['id'].toString()).toList();
//       List<dynamic> reports = response.data['result'] as List<dynamic>;
//       if(reports.any((element) {
//         DateTime currentDate = DateTime.now().subtract(Duration(minutes: 15));
//         DateTime reportDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(element['entryDate']);
//         if(reportDate.isAfter(currentDate)){
//           return true;
//         }
//         else{
//           return false;
//         }
//       })){
//         AwesomeNotifications().createNotification(
//           content: NotificationContent(
//               id: Random().nextInt(50),
//               channelKey: 'misc_alerts',
//               title: 'Lab Report',
//               body: 'Your report is ready.',
//               payload: {
//                 'reminderTypeId' : '4'
//               }
//           ),
//         );
//
//       }
//     }
//
//   }on DioException catch(e){
//     print(e);
//   }
//
//
//
// }
//
// void _opdReport({required String code,required String orgId}) async {
//   // Replace with your API endpoint
//   String url = '${Api.getLabReport}/$code/$orgId';
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
//       DateTime currentDate = DateTime.now().subtract(Duration(minutes: 15));
//       DateTime reportDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(element['entryDate']);
//       if(reportDate.isAfter(currentDate)){
//         return true;
//       }
//       else{
//         return false;
//       }
//     })){
//       AwesomeNotifications().createNotification(
//         content: NotificationContent(
//             id: Random().nextInt(50),
//             channelKey: 'misc_alerts',
//             title: 'OPD Report',
//             body: 'Your report is ready.',
//             payload: {
//               'reminderTypeId' : '6'
//             }
//         ),
//       );
//
//     }
//   }
//
// }
//
// Future<void> _request({required String code}) async {
//   // Replace with your API endpoint
//   String url = '${Api.requestList}/$code';
//   String name = '';
//
//   try{
//     final response = await dio.get(url,
//       options: Options(
//         sendTimeout: Duration(seconds: 10),
//         receiveTimeout: Duration(seconds: 10)
//       )
//     );
//
//     if (response.statusCode == 200) {
//
//       List<dynamic> reports = response.data['result'] as List<dynamic>;
//
//       print('request executed');
//
//       if(reports.any((element) {
//         DateTime currentDate = DateTime.now().subtract(Duration(minutes: 15));
//         DateTime reportDate = DateFormat('yyyy-MM-ddThh:mm:ss').parse(element['entryDate']);
//         name = '${element['firstName']} ${element['lastName']}';
//         if(reportDate.isAfter(currentDate)){
//           return true;
//         }
//         else{
//           return false;
//         }
//       })){
//         AwesomeNotifications().createNotification(
//           content: NotificationContent(
//               id: Random().nextInt(50),
//               channelKey: 'misc_alerts',
//               title: 'Family Request',
//               body: '$name sent you a request.',
//               payload: {
//                 'reminderTypeId' : '5'
//               }
//           ),
//         );
//
//       }
//     }
//   }on DioException catch(e){
//     print(e);
//   }
//
//
// }
//
//
//
//
//
//
