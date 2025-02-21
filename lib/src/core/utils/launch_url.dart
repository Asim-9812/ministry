



import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalLinks{


  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static Future<void> sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailTo',
      path: email,
    );
    await launchUrl(launchUri);
  }

  static Future<void> url(String url) async {
    final Uri launchUri = Uri(
      path: url,
    );
    await launchUrl(launchUri,mode: LaunchMode.externalApplication);
  }

  static Future<void> share(String url) async {
    final Uri launchUri = Uri(
      path: url,
    );
    await Share.shareUri(launchUri);
  }

}