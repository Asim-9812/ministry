



import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:khalti/khalti.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/utils/toaster.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/enquiry/presentation/ui/enquiry_html_report.dart';
import 'package:pinput/pinput.dart';

import '../../../../../core/resources/gap_manager.dart';
import '../../../../dashboard/presentation/ui/dashboard.dart';
import '../../../application/controller/enquiry_notifier.dart';
import '../../../application/providers/enquiry_provider.dart';
import '../../../data/services/khalti_services.dart';
import '../enquiry_paid_details.dart';
import '../enquiry_paid_html_report.dart';

class KhaltiPaymentUI extends ConsumerStatefulWidget {
  final Map<String, dynamic> data;
  const KhaltiPaymentUI({required this.data, super.key});

  @override
  ConsumerState<KhaltiPaymentUI> createState() => _KhaltiPaymentUIState();
}

class _KhaltiPaymentUIState extends ConsumerState<KhaltiPaymentUI> {


  final khaltiPrimaryColor = Color(0xFF4D286D);
  
  
  bool isLoggingIn = false;
  bool isLoading = false;
  bool isInitiated = false;
  bool isObscure = true;
  String? token;
  
  final phoneController = TextEditingController();
  final pinController = TextEditingController();
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar:  commonNavBar('Khalti Payment', color: khaltiPrimaryColor),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/icons/khalti.png', scale: 2,),

              if(token == null)
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)
                        ),
                        labelText: 'Phone number',
                        prefixIcon: Icon(Icons.phone,color: khaltiPrimaryColor,)
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if(value == null || value.trim().isEmpty){
                          return 'Phone number is required';
                        }
                        else if(value.length != 10){
                          return 'Number should be 10 digits';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    h10,
                    TextFormField(
                      controller: pinController,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)
                        ),
                        labelText: 'Pin number',
                        prefixIcon: Icon(Icons.pin,color: khaltiPrimaryColor,),
                        suffixIcon: IconButton(onPressed: ()=>setState(() {
                          isObscure = !isObscure;
                        }), icon: Icon(isObscure? CupertinoIcons.eye : CupertinoIcons.eye_slash , color: khaltiPrimaryColor,))
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if(value == null || value.trim().isEmpty){
                          return 'PIN is required';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    h10,
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: khaltiPrimaryColor,
                                foregroundColor: MyColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)
                                )
                              ),
                              onPressed: isLoggingIn ? null : () async {
                                if(formKey.currentState!.validate()){
                                  setState(() {
                                    isLoggingIn = !isLoggingIn;
                                  });
                                  try{
                                    final genToken = await KhaltiServices().initiatePayment(
                                        number: phoneController.text.trim(),
                                        pin: pinController.text.trim()
                                    );

                                    setState(() {
                                      token = genToken;
                                    });
                                  }catch (e){
                                    Toaster.error('$e');
                                  }
                                  setState(() {
                                    isLoggingIn = !isLoggingIn;
                                  });
                                }

                              },
                              child: isLoggingIn ? SpinKitDualRing(color: MyColors.white, size: 16,) :Text('Sign in')
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if(token != null)
              FadeIn(
                child: Column(
                  children: [
                    h20,
                    Text('An OTP has been sent to your registered mobile number. Please enter the 6-digit code below to verify and complete your payment'),
                    h20,
                
                    Pinput(
                      length: 6,
                      controller: otpController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    h20,
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: khaltiPrimaryColor,
                                  foregroundColor: MyColors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)
                                  )
                              ),
                              onPressed: () async {
                                if(otpController.text.trim().isNotEmpty){
                                  try{
                                    setState(() {
                                      isLoading = true;
                                    });
                                    final response = await KhaltiServices().confirmPayment(token: token!, otp: otpController.text.trim(), pin: pinController.text.trim());

                                    final code = await ref.read(enquiryNotifier.notifier).insertEnquiry(data: widget.data);
                                    if(code != null){
                                      ref.invalidate(enquiryListProvider);
                                      final value = await ref.read(enquiryNotifier.notifier).getEnquiryReport(passportNo: widget.data['passportNumber'], code: code);
                                      if(value == null){
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Dashboard()), (route) => false,);
                                      }
                                      else{
                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>EnquiryPaidHtml(html: value)), (route) => false,);
                                      }
                                    }
                                    else{
                                      Toaster.error('Something went wrong.');
                                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Dashboard()), (route) => false,);
                                    }

                                    Toaster.success('Payment Successful');
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }catch (e){
                                    print(e);
                                    Toaster.error('$e');
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                                else{
                                  Toaster.error('OTP is required');
                                }
                
                              },
                              child: isLoading? SpinKitDualRing(color: MyColors.white, size: 16,) :  Text('Confirm Payment')),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
