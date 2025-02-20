


import 'package:url_launcher/url_launcher_string.dart';

class ScanLauncher {
  ScanLauncher._();

  static Future<void> openUrl(String code) async {
    String url = code;
    if (url.startsWith('http://')) {
      url = url.replaceFirst('http://', 'https://');
      launchUrlString(url,mode: LaunchMode.externalApplication);
    }else{
      launchUrlString(url,mode: LaunchMode.externalApplication);
    }

    // final Uri uri = Uri(
    //     path: code,
    //     scheme: 'https'
    // );

  }
}