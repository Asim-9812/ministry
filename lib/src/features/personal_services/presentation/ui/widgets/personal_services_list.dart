

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/core/providers/user_info_provider.dart';
import 'package:ministry/src/core/utils/page_route.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/features/enquiry/presentation/ui/enquiry_list.dart';
import 'package:ministry/src/features/report/presentation/ui/medical_report_list.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/gap_manager.dart';
import '../../../../enquiry/application/controller/enquiry_notifier.dart';
import '../../../../enquiry/presentation/ui/enquiry_html_report.dart';
import '../../../items/items.dart';

class PersonalServicesList extends ConsumerWidget {
  const PersonalServicesList({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final passportNo = ref.watch(userInfoProvider)?.passportNo;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: personalList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 16/9,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0
          ),
          itemBuilder: (context,index){
            return Card(
              color: MyColors.white,
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: MyColors.black.withOpacity(0.2),
                  )
              ),
              elevation: 0,
              child: InkWell(
                onTap: () async {
                  if(index == 0 && passportNo != null){
                    routeTo(context, EnquiryList(passportNo: passportNo));
                    // final reportHtml = await ref.read(enquiryNotifier.notifier).getEnquiryReport(passportNo: passportNo);
                    //
                    // if(reportHtml == null){
                    //   Toaster.error('No appointment found');
                    // }
                    // else{
                    //   routeTo(context, EnquiryReportHtml(html: reportHtml));
                    // }
                  }
                  else if(index == 1){
                    routeTo(context, MedicalReportList());
                  }

                },
                splashColor: MyColors.primary.withOpacity(0.5),// Customize the splash color
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.all(4),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('${personalList[index].img}'),
                          h10,
                          Text('${personalList[index].name}',style: TextStyle(color: MyColors.primary,fontSize: 16,fontWeight: FontWeight.w500),maxLines: 1)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
