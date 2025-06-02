





import 'dart:io';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/features/enquiry/application/controller/enquiry_controller.dart';
import 'package:ministry/src/features/enquiry/domain/model/medical_agency_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/enquiry/application/providers/enquiry_provider.dart';
import 'package:ministry/src/features/enquiry/domain/model/enquiry_model.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/gap_manager.dart';
import '../../../dashboard/presentation/ui/dashboard.dart';
import '../../application/controller/enquiry_notifier.dart';
import 'helpers/download_enquiry_pdf.dart';

class EnquiryPayment extends ConsumerWidget {
  final Map<String, dynamic> data;
  final String date;
  const EnquiryPayment({required this.data, required this.date, super.key});

  @override
  Widget build(BuildContext context, ref) {

    final enquiryState = ref.watch(enquiryNotifier);
    final selectedCountry = ref.watch(enquiryController).selectedCountryDynamic;
    final selectedMedicalAgency = ref.watch(enquiryController).selectedMedical!;

    return Scaffold(
      appBar: commonNavBar('Details & Payment'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: MyColors.grey
                    ),
                    image: DecorationImage(image: AssetImage('assets/images/logo.png'),opacity: 0.05,fit: BoxFit.none,scale: 10)
                ),
                width: double.infinity,
                // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                          title: Text('Appointment Details',style: ph2,),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: MyColors.lightGrey.withValues(alpha: 120),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: MyColors.grey
                                )


                            ),
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Appointment Date & Time', style: ph3,),
                                Text(date, style: bh2,),

                                h10,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Passport No.', style: ph3,),
                                        Text(data['passportNumber'], style: bh2,),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text('Applied for', style: ph3,),
                                        Text(selectedCountry['value'], style: bh3,),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: MyColors.lightGrey.withValues(alpha: 120),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: MyColors.grey
                                )


                            ),
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Full name', style: ph3,),
                                Text(data['fullName'], style: bh2,),
                                h10,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Contact', style: ph3,),
                                        Text(data['contact'], style: bh3,),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text('Email', style: ph3,),
                                        Text(data['emailID'], style: bh3,),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if(data['queries'].trim().isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                  color: MyColors.lightGrey.withValues(alpha: 120),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: MyColors.grey
                                  )


                              ),
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Remarks', style: ph3,),
                                  Text(data['queries'], style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
                                ],
                              ),
                            ),
                          h10,
                        ],
                      ),
                    ),
                    h10,
        
        
                    // h10,
                    //
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    //   child: Text('Appointment Details',style: ph2,),
                    // ),
                    //
                    // Divider(),
                    //
                    //
                    // hospitalDetails(selectedMedicalAgency),
                    //
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: MyColors.lightGrey.withValues(alpha: 120),
                    //       borderRadius: BorderRadius.circular(12),
                    //       border: Border.all(
                    //           color: MyColors.grey
                    //       )
                    //
                    //
                    //   ),
                    //   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    //   width: double.infinity,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text('Appointment Date & Time', style: ph3,),
                    //       Text(date, style: bh2,),
                    //
                    //       h10,
                    //       Row(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text('Passport No.', style: ph3,),
                    //               Text(data['passportNumber'], style: bh2,),
                    //             ],
                    //           ),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.end,
                    //             children: [
                    //               Text('Applied for', style: ph3,),
                    //               Text(selectedCountry['value'], style: bh3,),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: MyColors.lightGrey.withValues(alpha: 120),
                    //       borderRadius: BorderRadius.circular(12),
                    //       border: Border.all(
                    //           color: MyColors.grey
                    //       )
                    //
                    //
                    //   ),
                    //   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    //   width: double.infinity,
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text('Full name', style: ph3,),
                    //       Text(data['fullName'], style: bh2,),
                    //       h10,
                    //       Row(
                    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Text('Contact', style: ph3,),
                    //               Text(data['contact'], style: bh3,),
                    //             ],
                    //           ),
                    //           Column(
                    //             crossAxisAlignment: CrossAxisAlignment.end,
                    //             children: [
                    //               Text('Email', style: ph3,),
                    //               Text(data['emailID'], style: bh3,),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // if(data['queries'].trim().isNotEmpty)
                    //   Container(
                    //     decoration: BoxDecoration(
                    //         color: MyColors.lightGrey.withValues(alpha: 120),
                    //         borderRadius: BorderRadius.circular(12),
                    //         border: Border.all(
                    //             color: MyColors.grey
                    //         )
                    //
                    //
                    //     ),
                    //     margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    //     width: double.infinity,
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text('Remarks', style: ph3,),
                    //         Text(data['queries'], style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
                    //       ],
                    //     ),
                    //   ),
                    //
                    // // Text('Passport No: passportNo', style: bh3,),
                    // // Text('Appointment date: date', style: bh3,),
                    // // h10,
                    // // Text('code'),
                    // // Text('Applied for: {enquiry.appliedForFormatted}'),
                    // // h10,
                    // //
                    // // Text('Full name: {enquiry.fullName}', style: bh3,),
                    // // Text('Email: {enquiry.emailID}', style: bh3,),
                    // // Text('Contact: {enquiry.contact}', style: bh3,),
                    // h10,
                  ],
                ),
              ),
            ),
            h20,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Payment Amount: Rs. 10.00',style: bh2,),
            ),
            h10,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Select payment method',style: br2,),
            ),
            h10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RadioListTile(
                  value: true,
                  groupValue: true,
                  onChanged:(value) {},
                  tileColor: MyColors.lightGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: MyColors.primary)
                  ),
                  title: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/icons/esewa.png', scale: 20,),
                      w10,
                      Text('Esewa', style: bh2,)
                    ],
                  ),
              ),
            ),
            h20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: MyColors.lightGrey,
                          foregroundColor: MyColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          )
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel')),
                  ),
                  w10,
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: MyColors.primary,
                          foregroundColor: MyColors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                          )
                        ),
                        onPressed: () async {
                          await ref.read(enquiryNotifier.notifier).insertEnquiry(data: data).whenComplete((){
                            ref.invalidate(enquiryListProvider);
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Dashboard()), (route) => false,);
                          });
                        },
                        child: enquiryState.isLoading
                            ? SpinKitDualRing(color: MyColors.white,size: 16,)
                            : Text('Confirm Payment')),
                  ),
                ],
              ),
            ),
        
          ],
        ),
      ),
    );
  }

  Widget hospitalDetails(MedicalAgencyModel agency){
    return Container(
      decoration: BoxDecoration(
          color: MyColors.lightGrey.withValues(alpha: 120),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: MyColors.grey
          )


      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hospital Details', style: ph3,),
          Text('${agency.organizationname}', style: bh2,),
          Text('${agency.fullAddress}', style: br1,),
        ],
      ),
    );
  }


}
