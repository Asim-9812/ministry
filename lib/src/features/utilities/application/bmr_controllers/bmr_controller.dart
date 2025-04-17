




import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/utilities/application/height_converter.dart';


final bmrController = ChangeNotifierProvider.autoDispose((ref)=>BmrController());

class BmrController extends ChangeNotifier{

  int genderIndex = 0;
  int unitIndex = 0;
  int age = 18;
  double height = (243.84 + 91.44) / 2;
  var heightInFt = convertCmToFeetAndInches((243.84 + 91.44) / 2);
  double weight = 60;
  TextEditingController weightController = TextEditingController(text: '60');
  final formKey = GlobalKey<FormState>();



  void changeGender(int val){
    genderIndex = val;
    notifyListeners();
  }

  void changeUnit(int val){
    unitIndex = val;
    notifyListeners();
  }

  void updateHeight(double newHeight){
    height = newHeight;
    heightInFt = convertCmToFeetAndInches(newHeight);
    notifyListeners();
  }

  void updateAge(int newAge){
    age = newAge;
    notifyListeners();
  }

  void updateWeight(double newWeight){
    weight = newWeight;
    notifyListeners();
  }


}