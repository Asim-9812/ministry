



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signupController = ChangeNotifierProvider<SignupController>((ref)=>SignupController());


class SignupController extends ChangeNotifier{

  bool obscureText = true;
  bool obscureText2 = true;

  String? gender;
  int? genderId;
  bool genderError = false;

  String countryCode = 'NP';
  String number = '977';

  TextEditingController  passportController = TextEditingController();
  TextEditingController  firstNameController = TextEditingController();
  TextEditingController  lastNameController = TextEditingController();
  TextEditingController  contactController = TextEditingController();
  TextEditingController  emailController = TextEditingController();
  TextEditingController  passwordController = TextEditingController();
  TextEditingController  confirmPasswordController = TextEditingController();


  void changeObscure1(bool value){
    obscureText = value;
    notifyListeners();
  }

  void changeObscure2(bool value){
    obscureText2 = value;
    notifyListeners();
  }

  void selectGender(String value, int id){
    gender = value;
    genderId = id;
    genderError = false;
    notifyListeners();
  }

  void toggleGenderError(){
    genderError = true;
    notifyListeners();
  }


  void setCode(String value, String dialCode){
    countryCode = value;
    number = dialCode;
    notifyListeners();

  }

}