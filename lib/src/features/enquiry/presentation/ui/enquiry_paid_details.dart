//
// import 'package:flutter/services.dart';
// import 'package:ministry/src/core/utils/toaster.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';
// import 'package:ministry/src/core/widgets/common_widgets.dart';
// import 'package:ministry/src/features/enquiry/application/providers/enquiry_provider.dart';
// import 'package:ministry/src/features/enquiry/domain/model/enquiry_model.dart';
// import 'package:flutter_to_pdf/flutter_to_pdf.dart';
// import '../../../../core/resources/color_manager.dart';
// import '../../../../core/resources/font_manager.dart';
// import '../../../../core/resources/gap_manager.dart';
// import '../../../dashboard/presentation/ui/dashboard.dart';
// import 'helpers/download_enquiry_pdf.dart';
//
//
//
// class EnquiryPaidDetails extends ConsumerWidget {
//   final EnquiryModel enquiry;
//   const EnquiryPaidDetails({required this.enquiry, super.key});
//
//   @override
//   Widget build(BuildContext context, ref) {
//
//     final GlobalKey previewContainer = GlobalKey();
//
//
//     final ExportOptions options = ExportOptions(
//       pageFormatOptions: PageFormatOptions.a4(),
//       textFieldOptions: TextFieldOptions.uniform(
//         interactive: false,
//       ),
//       checkboxOptions: CheckboxOptions.uniform(
//         interactive: false,
//       ),
//     );
//
//     final ExportDelegate exportDelegate = ExportDelegate(options: options);
//
//     final agencyDetails = ref.watch(medicalAgenciesByCodeProvider(enquiry.medicalAgency));
//     final dateTime = DateFormat('dd MMMM, yyy, HH:mm a').format(enquiry.appointmentDate);
//
//     return Scaffold(
//       appBar: commonNavBar('Details',
//         onTap: (){
//           ref.invalidate(enquiryListProvider);
//
//           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Dashboard()), (route) => false,);
//         }
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
//             child: RepaintBoundary(
//               key: previewContainer,
//               child: ExportFrame(
//                 frameId: 'appointmentDoc',
//                 exportDelegate: exportDelegate,
//                 child: Container(
//                   color: MyColors.white,
//                   child: Column(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(
//                             color: MyColors.white,
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(
//                               color: MyColors.grey
//                             ),
//                             image: DecorationImage(image: AssetImage('assets/images/hospital_logo.png'),opacity: 0.05,fit: BoxFit.none,scale: 5)
//                         ),
//                         width: double.infinity,
//                         // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             h10,
//
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                               child: Text('Appointment Details',style: ph2,),
//                             ),
//                             Divider(),
//
//                             agencyDetails.when(
//                                 data: (agencyInfo){
//                                   if(agencyInfo== null){
//                                     return hospitalDetails(enquiry);
//                                   }
//                                   else{
//                                     return Container(
//                                       decoration: BoxDecoration(
//                                           color: MyColors.lightGrey.withValues(alpha: 120),
//                                           borderRadius: BorderRadius.circular(12),
//                                           border: Border.all(
//                                               color: MyColors.grey
//                                           )
//                                       ),
//                                       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                                       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                                       width: double.infinity,
//                                       child: Column(
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text('Hospital Details', style: ph3,),
//                                           Text('${enquiry.medicalAgencyFullName}', style: bh2,),
//                                           Text('Province ${agencyInfo.fullAddress}', style: br2,),
//                                         ],
//                                       ),
//                                     );
//                                   }
//                                 },
//                                 error: (error, stack)=>hospitalDetails(enquiry),
//                                 loading: ()=>hospitalDetails(enquiry),
//                             ),
//
//
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: MyColors.lightGrey.withValues(alpha: 120),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                       color: MyColors.grey
//                                   )
//                               ),
//                               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                               width: double.infinity,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('Appointment Date & Time', style: ph3,),
//                                   Text(dateTime, style: bh2,),
//
//                                   h10,
//                                   Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text('Passport No.', style: ph3,),
//                                           Text(enquiry.passportNumber, style: bh2,),
//                                         ],
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.end,
//                                         children: [
//                                           Text('Applied for', style: ph3,),
//                                           Text(enquiry.appliedForFormatted, style: bh3,),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: MyColors.lightGrey.withValues(alpha: 120),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                       color: MyColors.grey
//                                   )
//
//
//                               ),
//                               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                               width: double.infinity,
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('Full name', style: ph3,),
//                                   Text(enquiry.fullName, style: bh2,),
//                                   h10,
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Text('Contact', style: ph3,),
//                                           Text(enquiry.contact, style: bh3,),
//                                         ],
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.end,
//                                         children: [
//                                           Text('Email', style: ph3,),
//                                           Text(enquiry.emailID, style: bh3,),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             if(enquiry.queries.trim().isNotEmpty)
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: MyColors.lightGrey.withValues(alpha: 120),
//                                   borderRadius: BorderRadius.circular(12),
//                                   border: Border.all(
//                                       color: MyColors.grey
//                                   )
//
//
//                               ),
//                               margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                               padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                               width: double.infinity,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('Remarks', style: ph3,),
//                                   Text(enquiry.queries, style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
//                                 ],
//                               ),
//                             ),
//
//                             // Text('Passport No: passportNo', style: bh3,),
//                             // Text('Appointment date: date', style: bh3,),
//                             // h10,
//                             // Text('code'),
//                             // Text('Applied for: {enquiry.appliedForFormatted}'),
//                             // h10,
//                             //
//                             // Text('Full name: {enquiry.fullName}', style: bh3,),
//                             // Text('Email: {enquiry.emailID}', style: bh3,),
//                             // Text('Contact: {enquiry.contact}', style: bh3,),
//                             h10,
//                           ],
//                         ),
//                       ),
//                       h10,
//                       DottedBorder(
//                           dashPattern: [2,2],
//                           color: MyColors.grey,
//                           borderType: BorderType.RRect,
//                           radius: Radius.circular(12),
//                           child: Container(
//                             decoration: BoxDecoration(
//                               color: MyColors.lightGrey,
//                               borderRadius: BorderRadius.circular(12)
//                             ),
//                             width: double.infinity,
//                             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text('Payment Info',style: bh3,),
//                                 h10,
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text('Rs. 10.00', style: ph1,),
//                                     Row(
//                                       children: [
//                                         Text('TXN ID : 1234567890',style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic),),
//                                         w04,
//                                         InkWell(
//                                             onTap: (){
//                                               Clipboard.setData(ClipboardData(text: '1234567890'));
//                                               Toaster.message('Transaction id copied');
//                                             },
//                                             child: Icon(Icons.copy,color: MyColors.black,size: 10,))
//                                       ],
//                                     )
//                                     ],
//                                 ),
//                                 h10,
//                                 Text('Date: 02 June 2025, 10:30 AM', style: br2),
//                               ],
//                             ),
//                           )
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           h20,
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Expanded(
//                   child: TextButton(
//                     style: TextButton.styleFrom(
//                         backgroundColor: MyColors.primary,
//                         foregroundColor: MyColors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12))),
//                     onPressed: () async {
//
//                       await saveAsImagePdf(previewContainer, enquiry.medicalAgency);
//                       Toaster.success('Saved to Downloads folder');
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.picture_as_pdf, color: MyColors.white),
//                         w10,
//                         Text('Save as PDF'),
//                       ],
//                     ),
//                   ),
//                 ),
//                 w10,
//                 Expanded(
//                   child: TextButton(
//                     style: TextButton.styleFrom(
//                         backgroundColor: MyColors.primary,
//                         foregroundColor: MyColors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12))),
//                     onPressed: () async {
//                       await saveAsImage(previewContainer, enquiry.medicalAgency);
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.image, color: MyColors.white),
//                         w10,
//                         Text('Save as Image'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//
//         ],
//       ),
//     );
//   }
//
//   Widget hospitalDetails(EnquiryModel enquiry){
//     return Container(
//       decoration: BoxDecoration(
//           color: MyColors.lightGrey.withValues(alpha: 120),
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//               color: MyColors.grey
//           )
//
//
//       ),
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       width: double.infinity,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Hospital Details', style: ph3,),
//           Text('${enquiry.medicalAgencyFullName}', style: bh2,),
//           Text('${enquiry.medicalAgency}', style: br1,),
//         ],
//       ),
//     );
//   }
//
//
// }
