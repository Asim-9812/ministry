

import 'package:flutter/material.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/report/data/sample_report.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MedicalReport extends StatelessWidget {
  const MedicalReport({super.key});

  @override
  Widget build(BuildContext context) {

    final wbController = WebViewController()
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadHtmlString(reportHtmlString);
    return Scaffold(
      appBar: commonNavBar('Report'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: WebViewWidget(controller: wbController),
      ),
    );
  }
}
