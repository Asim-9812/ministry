

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/utils/page_route.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/report/application/providers/medical_report_provider.dart';
import 'package:ministry/src/features/report/data/sample_report.dart';
import 'package:ministry/src/features/report/presentation/ui/medical_report.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MedicalReportList extends ConsumerWidget {
  const MedicalReportList({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final reportListAsyncValue = ref.watch(medicalReportListProvider);


    return Scaffold(
      appBar: commonNavBar('Report'),
      body: reportListAsyncValue.when(
          data: (reportList){
            return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                itemCount: reportList.length,
                itemBuilder: (context, index){
                  final report = reportList[index];
                  return ListTile(
                    onTap: ()=>routeTo(context, MedicalReport(html: report['reports'])),
                    tileColor: MyColors.lightGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    leading: Icon(Icons.file_present_rounded,color: MyColors.primary,),
                    title: Text('${report['patientId']}'),
                  );
                }
            );
          },
          error: (error,stack)=>Center(child: Text('$error'),),
          loading: ()=>Center(child: SpinKitDualRing(color: MyColors.primary,size: 16,),)
      ),
    );
  }
}
