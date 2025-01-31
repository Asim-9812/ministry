

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final loginController = ChangeNotifierProvider.autoDispose((ref)=>LoginController());


class LoginController extends ChangeNotifier{

  bool isObscure = true;
  bool remember = false;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void changeObscure(){
    isObscure = !isObscure;
    notifyListeners();
  }
  void changeRemember(){
    remember = !remember;
    notifyListeners();
  }

}