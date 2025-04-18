

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/report/application/providers/medical_report_provider.dart';
import 'package:ministry/src/features/report/data/sample_report.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MedicalReport extends ConsumerWidget {
  const MedicalReport({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final reportAsyncValue = ref.watch(medicalReportProvider);


    return Scaffold(
      appBar: commonNavBar('Report'),
      body: reportAsyncValue.when(
          data: (report){
            final wbController = WebViewController()
              ..enableZoom(true)
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..loadHtmlString(report);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: WebViewWidget(controller: wbController));
          },
          error: (error,stack)=>Center(child: Text('$error'),),
          loading: ()=>Center(child: SpinKitDualRing(color: MyColors.primary,size: 16,),)
      ),
    );
  }
}
