


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/utils/page_route.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/enquiry/application/controller/enquiry_controller.dart';
import 'package:ministry/src/features/enquiry/application/controller/enquiry_notifier.dart';
import 'package:ministry/src/features/enquiry/presentation/ui/country_picker.dart';
import 'package:ministry/src/features/enquiry/presentation/ui/enquiry_html_report.dart';
import 'package:ministry/src/features/enquiry/presentation/ui/enquiry_list.dart';

import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/gap_manager.dart';

class Enquiry extends ConsumerWidget {
  const Enquiry({super.key});

  @override
  Widget build(BuildContext context, ref) {

    final controller = ref.watch(enquiryController).passController;
    final enquiryState = ref.watch(enquiryNotifier);

    return Scaffold(
      appBar: commonNavBar('Appointments'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            h10,
            Text('Search for your appointments', style: br1,),
            h10,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: MyColors.primary
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: MyColors.primary
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: MyColors.primary
                          )
                      ),
                      labelText: 'Passport no.',
                      prefixIcon: Icon(Icons.search,color: MyColors.primary,)
                    ),
                  ),
                ),
                w10,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: MyColors.primary,
                          foregroundColor: MyColors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          )
                      ),
                      onPressed: () async {
                        if(controller.text.trim().isEmpty){
                          Toaster.error('Passport number is required');
                        }
                        else{



                          routeTo(context, EnquiryList(passportNo: controller.text.trim()));
                          controller.clear();
                        }
                      },
                      child: enquiryState.isLoading? SpinKitDualRing(color: MyColors.white, size: 16,) : Text('Next')
                  ),
                ),
              ],
            ),
            h20,
            Row(
              children: [
                Expanded(child: Divider()),
                w10,
                Text('OR'),
                w10,
                Expanded(child: Divider()),
              ],
            ),
            h20,
            Row(
              children: [
                Expanded(
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: MyColors.primary,
                          foregroundColor: MyColors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)
                          )
                      ),
                      onPressed: ()=>routeTo(context, CountryPicker()),
                      child: Text('Get an appointment')
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
