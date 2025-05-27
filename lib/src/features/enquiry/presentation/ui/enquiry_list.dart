
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/resources/font_manager.dart';
import 'package:ministry/src/core/utils/shimmers.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/enquiry/application/providers/enquiry_provider.dart';

import '../../../../core/resources/gap_manager.dart';

class EnquiryList extends ConsumerWidget {

  final String passportNo;

  const EnquiryList({required this.passportNo, super.key});

  @override
  Widget build(BuildContext context, ref) {

    final enquiryList = ref.watch(enquiryListProvider(passportNo));

    return Scaffold(
      appBar: commonNavBar('Enquiries'),
      body: enquiryList.when(
          data: (enquiries){
            if(enquiries.isEmpty){
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off, color: MyColors.grey, size: 48,),
                    h10,
                    Text('No enquiries found.', style: bh3,)
                  ],
                ),
              );
            }
            return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                itemCount: enquiries.length,
                itemBuilder: (context, index) {
                  final enquiry = enquiries[index];
                  final code = enquiry.medicalAgency;
                  final date = DateFormat('yyyy-MM-dd HH:mm a').format(enquiry.appointmentDate);
                  final status = enquiry.extra1;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ListTile(
                        onTap: () async {
                          await showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                    child: Material(
                                      child: Container(
                                        color: MyColors.white,
                                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            h20,
                                            Text('Appointment Details', style: bh2,),
                                            Divider(),
                                            Text('Passport No: $passportNo', style: bh3,),
                                            Text('Appointment date: $date', style: bh3,),
                                            h10,
                                            Text('$code'),
                                            Text('Applied for: ${enquiry.appliedForFormatted}'),
                                            h10,

                                            Text('Full name: ${enquiry.fullName}', style: bh3,),
                                            Text('Email: ${enquiry.emailID}', style: bh3,),
                                            Text('Contact: ${enquiry.contact}', style: bh3,),
                                            h10,
                                            Center(
                                              child: TextButton(
                                                  style: TextButton.styleFrom(
                                                      backgroundColor: MyColors.primary,
                                                      foregroundColor: MyColors.white,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(12)
                                                      )
                                                  ),
                                                  onPressed: ()=>Navigator.pop(context), child: Text('OK')),
                                            )

                                          ],
                                        ),
                                      ),
                                    )
                                );
                              },
                          );
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
                            Text(enquiry.medicalAgency,style: br1, maxLines: 1,),
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
            );
          },
          error: (error, stack)=> Center(child: Text('$error', style: bh3,)),
          loading: ()=>Center(child: SpinKitDualRing(color: MyColors.primary))
      ),
    );
  }




}
