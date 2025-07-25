
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/resources/font_manager.dart';
import 'package:ministry/src/core/utils/page_route.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/enquiry/application/controller/enquiry_list_controller.dart';
import 'package:ministry/src/features/enquiry/application/providers/enquiry_provider.dart';
import 'package:ministry/src/features/enquiry/presentation/ui/enquiry_details.dart';
import 'package:ministry/src/features/login/application/login_notifier.dart';

import '../../../../core/resources/gap_manager.dart';
import '../../../../core/utils/toaster.dart';
import '../../application/controller/enquiry_notifier.dart';
import 'enquiry_html_report.dart';

class EnquiryList extends ConsumerWidget {


  const EnquiryList({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final filter = ref.watch(enquiryListController).filter;

    final enquiryList = ref.watch(enquiryListProvider(filter));

    return Scaffold(
      appBar: commonNavBar('Appointments',
        onTap: (){
          ref.invalidate(enquiryListProvider);
          Navigator.pop(context);
        }
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...[{'id':0,'type' : 'All'}, {'id':1,'type' : 'My Appointments'}, {'id':2,'type' : 'Others'}].map((e)=>
                      InkWell(
                        onTap: (){
                          ref.read(enquiryListController.notifier).changeFilter(e['id'] as int);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              color:e['id'] == filter ? MyColors.primary : MyColors.lightGrey,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Text(e['type'].toString(), style: e['id'] == filter ? wr1 : br1,),
                        ),
                      )
                  ).toList()
                ],
              ),
            ),
          ),
          h10,
          enquiryList.when(
              data: (enquiries){
                return Expanded(
                  child: enquiries.isEmpty
                      ? RefreshIndicator(
                    onRefresh: () async => ref.refresh(enquiryListProvider(filter)),
                    child: Center(
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          // mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, color: MyColors.grey, size: 48,),
                            h10,
                            Text('No Appointments found.', style: bh3,)
                          ],
                        ),
                      ),
                    ),
                  )
                      : RefreshIndicator(
                        onRefresh: () async => ref.refresh(enquiryListProvider(filter)),
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemCount: enquiries.length,
                          itemBuilder: (context, index) {
                            final enquiry = enquiries[index];
                            final code = enquiry.medicalAgency;
                            final date = DateFormat('yyyy-MM-dd').format(enquiry.appointmentDate);
                            // final status = enquiry.extra1;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: ListTile(
                                  onTap: () async {
                                    Toaster.message('Please wait...');
                                    final reportHtml = await ref.read(enquiryNotifier.notifier).getEnquiryReport(passportNo: enquiry.passportNumber, code: enquiry.id.toString());

                                    if(reportHtml == null){
                                      Toaster.error('Something went wrong. Try again later');
                                    }
                                    else{
                                      routeTo(context, EnquiryReportHtml(html: reportHtml));
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: BorderSide(
                                          color: MyColors.primary
                                      )
                                  ),
                                  // tileColor: MyColors.lightGrey,
                                  leading: Icon(Icons.file_copy_outlined, color: MyColors.primary,),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(enquiry.medicalAgencyFullName,style: br1, maxLines: 1,),
                                      Text('Passport No. ${enquiry.passportNumber}',style: br2,),
                                    ],
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(date),
                                      // status == null
                                      //     ? Container(
                                      //       decoration: BoxDecoration(
                                      //         color: MyColors.lightGrey,
                                      //         borderRadius: BorderRadius.circular(8)
                                      //       ),
                                      //       padding: EdgeInsets.all(4),
                                      //       child: Text('Pending'))
                                      //     : status.toLowerCase() == 'accepted'
                                      //     ? Container(
                                      //       decoration: BoxDecoration(
                                      //           color: MyColors.green,
                                      //           borderRadius: BorderRadius.circular(8)
                                      //       ),
                                      //       padding: EdgeInsets.all(4),
                                      //       child: Text('Accepted',style: TextStyle(color: MyColors.white),))
                                      //     : Container(
                                      //       decoration: BoxDecoration(
                                      //           color: MyColors.red,
                                      //           borderRadius: BorderRadius.circular(8)
                                      //       ),
                                      //       padding: EdgeInsets.all(4),
                                      //       child: Text('Rejected',style: TextStyle(color: MyColors.white))),
                                    ],
                                  )
                              ),
                            );
                          },
                        ),
                      ),
                );
              },
              error: (error, stack)=> Center(child: Text('$error', style: bh3,)),
              loading: ()=>Center(child: SpinKitDualRing(color: MyColors.primary, size: 16,))
          ),
        ],
      ),
    );
  }

}
