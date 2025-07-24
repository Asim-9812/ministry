


import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ministry/src/core/resources/color_manager.dart';
import 'package:ministry/src/core/widgets/common_widgets.dart';
import 'package:ministry/src/features/sign_up/application/controller/signup_controller.dart';
import 'package:ministry/src/features/sign_up/application/signup_notifier.dart';
import '../../../core/providers/user_info_provider.dart';
import '../../../core/resources/font_manager.dart';
import '../../../core/resources/gap_manager.dart';
import '../../../core/utils/page_route.dart';
import '../../../core/utils/toaster.dart';
import '../../dashboard/application/controller/dashboard_controller.dart';
import '../../dashboard/presentation/ui/dashboard.dart';
import '../../login/application/login_notifier.dart';


class SignUp extends ConsumerWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(signupController);
    final formKey = GlobalKey<FormState>();
    final passportController = controller.passportController;
    final firstNameController = controller.firstNameController;
    final lastNameController = controller.lastNameController;
    final contactController = controller.contactController;
    final emailController = controller.emailController;
    final passwordController = controller.passwordController;
    final confirmPasswordController = controller.confirmPasswordController;
    final obscureText = controller.obscureText;
    final obscureText2 = controller.obscureText2;
    final selectedGender = controller.gender;
    final selectedGenderId = controller.genderId;
    final genderError = controller.genderError;
    final genderList = ['Male', 'Female', 'Other'];

    final signUpState = ref.watch(signupNotifierProvider);

    final countryCode = controller.countryCode;
    final dialCode = controller.number;



    return Scaffold(
      appBar: commonNavBar('Sign Up'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller:  passportController,
                  textCapitalization: TextCapitalization.characters,
                  onTapOutside: (event) => FocusManager().primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: MyColors.primary
                      )
                    ),
                    focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    labelText: 'Passport No.',
                    prefixIcon: Icon(Icons.account_box,color: MyColors.primary,),
                  ),
                  validator: (val){
                    if(val == null || val.trim().isEmpty){
                      return 'Passport number is required';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                h10,
                TextFormField(
                  controller:  firstNameController,
                  keyboardType: TextInputType.name,
                  onTapOutside: (event) => FocusManager().primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: MyColors.primary
                      )
                    ),
                    focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    labelText: 'First Name',
                    prefixIcon: Icon(Icons.person,color: MyColors.primary,),
                  ),
                  validator: (val){
                    if(val == null || val.trim().isEmpty){
                      return 'First name is required';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                h10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller:  lastNameController,
                        keyboardType: TextInputType.name,
                        onTapOutside: (event) => FocusManager().primaryFocus?.unfocus(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: MyColors.primary
                            )
                          ),
                          focusedBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: MyColors.primary
                              )
                          ),
                          enabledBorder:  OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: MyColors.primary
                              )
                          ),
                          labelText: 'Last Name',
                          prefixIcon: Icon(Icons.person,color: MyColors.primary,),
                        ),
                        validator: (val){
                          if(val == null || val.trim().isEmpty){
                            return 'Last name is required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ),
                    w08,
                    PopupMenuButton(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: genderError ? MyColors.red : MyColors.primary
                            )
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(selectedGender == null ? 'Gender' : selectedGender),
                            Icon(Icons.arrow_drop_down_outlined)
                          ],
                        ),
                      ),
                      position: PopupMenuPosition.under,
                      itemBuilder: (context) => genderList.map((e){
                        return PopupMenuItem(
                          onTap: () {
                            final id = genderList.indexOf(e) + 1;
                            ref.read(signupController.notifier).selectGender(e, id);
                          },
                          child: Text(e),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                h10,

                TextFormField(
                  controller: contactController,
                  keyboardType: TextInputType.number,
                  onTapOutside: (event) => FocusManager().primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    labelText: 'Contact',
                    prefixIcon: CountryCodePicker(
                      flagWidth: 18,
                      initialSelection: countryCode,
                      onChanged: (value) {
                        print(value.dialCode);
                        ref.read(signupController.notifier).setCode(value.code!, value.dialCode!);
                      },
                    ),
                  ),
                  validator: (val){
                    if(val == null || val.trim().isEmpty){
                      return 'Contact is required';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                h10,
                TextFormField(
                  controller: emailController,
                  onTapOutside: (event) => FocusManager().primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    labelText: 'Email ${countryCode == 'NP' ? '(Optional)' : ''}',
                    prefixIcon: Icon(Icons.email,color: MyColors.primary,),
                  ),
                  validator: (val){
                    if(countryCode != 'NP' && (val == null || val.trim().isEmpty)){
                      return 'Email is required';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                h10,
                TextFormField(
                  obscureText: obscureText,
                  controller: passwordController,
                  onTapOutside: (event) => FocusManager().primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: MyColors.primary
                        )
                    ),
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock,color: MyColors.primary,),
                      suffixIcon: IconButton(
                          onPressed: ()=>ref.read(signupController.notifier).changeObscure1(!obscureText),
                          icon: Icon(obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,color: MyColors.primary,))
                  ),
                  validator: (val){
                    if(val == null || val.trim().isEmpty){
                      return 'Password is required';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                h10,
                TextFormField(
                  obscureText: obscureText2,
                  controller: confirmPasswordController,
                  onTapOutside: (event) => FocusManager().primaryFocus?.unfocus(),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: MyColors.primary
                          )
                      ),
                      focusedBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: MyColors.primary
                          )
                      ),
                      enabledBorder:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: MyColors.primary
                          )
                      ),
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock,color: MyColors.primary,),
                      suffixIcon: IconButton(
                          onPressed: ()=>ref.read(signupController.notifier).changeObscure2(!obscureText2),
                          icon: Icon(obscureText2 ? CupertinoIcons.eye : CupertinoIcons.eye_slash,color: MyColors.primary,))
                  ),
                  validator: (val){
                    if(val == null || val.trim().isEmpty){
                      return 'Confirm your password';
                    }
                    else if(val != passwordController.text.trim()){
                      return 'Password does not match';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                h10,
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.primary,
                            shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            )
                        ),
                        onPressed: () async {


                          if(formKey.currentState!.validate()){
                            if(selectedGender == null){
                              ref.read(signupController.notifier).toggleGenderError();
                              Toaster.error('Select a gender');
                            }
                            else{
                              final data = {
                                "id": 0,
                                "userName": passportController.text.trim().toUpperCase(),
                                "password": passwordController.text.trim(),
                                "verify": true,
                                "createdDate": "2025-07-22T04:09:19.430Z",
                                "firstName": firstNameController.text.toUpperCase(),
                                "lastName": lastNameController.text.toUpperCase(),
                                "gender": '$selectedGenderId',
                                "email": emailController.text.trim(),
                                "contact": dialCode + contactController.text.trim(),
                                "key": "string",
                                "orgId": "SUP",
                                "flag": "string",
                                "passportNo": passportController.text.trim().toUpperCase()
                              };

                              final isSignedUp = await ref.read(signupNotifierProvider.notifier).signUp(data: data);

                              if(isSignedUp) {
                                Toaster.success('Signup successful! Please log in to continue.');
                                Navigator.pop(context);

                              }

                            }
                          }
                        },
                        child: signUpState.isLoading
                            ? SpinKitDualRing(color: MyColors.white, size: 16,)
                            : const Text('Sign up',style: wh2,),
                      ),
                    ),
                    h30
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
