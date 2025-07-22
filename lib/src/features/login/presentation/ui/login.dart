


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ministry/src/core/providers/user_info_provider.dart';
import 'package:ministry/src/core/utils/page_route.dart';
import 'package:ministry/src/features/login/application/login_controller.dart';
import 'package:ministry/src/core/api/api.dart';
import 'package:ministry/src/features/sign_up/presentation/sign_up.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/gap_manager.dart';
import '../../../health_tips/application/providers/healthTips_repository_provider.dart';
import '../../../public_notices/application/providers/notice_repository_provider.dart';
import '../../../report/application/providers/medical_report_repository_provider.dart';
import '../../application/login_notifier.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final loginNotifier = ref.read(loginNotifierProvider.notifier);
    final loginState = ref.watch(loginNotifierProvider);
    final isObscure = ref.watch(loginController).isObscure;
    final remember = ref.watch(loginController).remember;
    final formKey = ref.watch(loginController).formKey;
    final usernameController = ref.watch(loginController).usernameController;
    final passwordController = ref.watch(loginController).passwordController;

    return SafeArea(
      child: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.primary,
                            image: DecorationImage(image: AssetImage('assets/images/cover.png'),alignment: Alignment.bottomRight,fit: BoxFit.contain)
                        ),
                      )
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        color: MyColors.white,
                      )
                  ),
                ],
              ),
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AutofillGroup(
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(logoUrl,width: 100,height: 100,),
                                h10,
                                Text('Sign In',style: TextStyle(color: MyColors.primary,fontSize: 32,fontWeight: FontWeight.bold),),
                                h10,
                                TextFormField(
                                  autofillHints: [AutofillHints.username],
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person,color: MyColors.primary,),
                                    labelText: 'Passport No.',
                                    labelStyle: bh2,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: MyColors.primary,
                                            width: 1
                                        )
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                            color: MyColors.primary,
                                            width: 1
                                        )
                                    ),
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
                                  obscureText: isObscure,
                                  autofillHints: [AutofillHints.password],
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock,color: MyColors.primary,),
                                      labelText: 'Password',
                                      labelStyle: bh2,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: MyColors.primary,
                                              width: 1
                                          )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(
                                              color: MyColors.primary,
                                              width: 1
                                          )
                                      ),
                                      suffixIcon: IconButton(
                                          onPressed: (){
                                            ref.read(loginController.notifier).changeObscure();
                                          },
                                          icon: Icon(isObscure ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill,color: MyColors.primary,)
                                      )
                                  ),
                                  onFieldSubmitted: (val) async {
                                    if(formKey.currentState!.validate()){
                                      final username = usernameController.text.trim();
                                      final password = passwordController.text.trim();
                                      await loginNotifier.login(username: username, password: password).whenComplete((){
                                        ref.refresh(userInfoProvider);
                                      });
                                    }
                                  },
                                  validator: (val){
                                    if(val == null || val.trim().isEmpty){
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                ),
                            
                                h10,
                            
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text('Remember me', style: bh3,),
                                    Checkbox(
                                      activeColor: MyColors.primary,
                            
                                        value: remember,
                                        onChanged: (val){
                                          ref.read(loginController.notifier).changeRemember();
                                        }
                                    )
                                  ],
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
                                        onPressed: loginState.isLoading
                                            ? null
                                            : () async {

                                          // await NotificationController.scheduleNotification(id: 1, title: 'title', body: 'body', scheduleTime: DateTime.now().add(Duration(seconds: 5)));
                                                if(formKey.currentState!.validate()){
                                                  final username = usernameController.text.trim();
                                                  final password = passwordController.text.trim();
                                                  await loginNotifier.login(username: username, password: password).whenComplete((){
                                                    TextInput.finishAutofillContext(shouldSave: remember);
                                                    ref.refresh(userInfoProvider);
                                                    ref.refresh(healthRepositoryProvider);
                                                    ref.refresh(noticeRepositoryProvider);
                                                    ref.refresh(medicalReportRepositoryProvider);
                                                  });
                                                }
                            
                                            },
                                        child: loginState.isLoading
                                            ? const SpinKitDualRing(color: MyColors.white, size: 16,)
                                            : const Text('Login',style: wh2,),
                                      ),
                                    ),
                                    h30
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                              backgroundColor: MyColors.grey.withValues(alpha: 150),
                                              shape: ContinuousRectangleBorder(
                                                  borderRadius: BorderRadius.circular(24)
                                              )
                                          ),
                                        onPressed: ()=>routeTo(context, SignUp()),
                                        child: const Text('Sign up',style: ph2,),
                                      ),
                                    ),
                                    h30
                                  ],
                                ),
                                h50,
                                Text('Version 1.0.0 + b2',style: bh3,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
