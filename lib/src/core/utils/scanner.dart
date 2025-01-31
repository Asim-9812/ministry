//
//
//
//
// import 'package:permission_handler/permission_handler.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
// import 'package:url_launcher/url_launcher_string.dart';
//
//
// class ScanLauncher {
//   ScanLauncher._();
//
//   static Future<void> openUrl(String code) async {
//     // final Uri uri = Uri(
//     //     path: code,
//     //     scheme: 'https'
//     // );
//     launchUrlString(code,mode: LaunchMode.externalApplication);
//   }
// }
//
// Future qrScan() async {
//   await Permission.camera.request();
//   String? barcode = await scanner.scan();
//   if (barcode == null) {
//     //print('nothing return.');
//   } else {
//     //print('this is the barcode : $barcode');
//     redirectUrl(barcode);
//   }
// }
//
// void redirectUrl(String url) {
//   if (url.startsWith('http://')) {
//     url = url.replaceFirst('http://', 'https://');
//     ScanLauncher.openUrl(url);
//   }else{
//     ScanLauncher.openUrl(url);
//   }
//
// }