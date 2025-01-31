






import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final healthTipsCarousalController = ChangeNotifierProvider((ref)=>HealthTipsCarousalController());


class HealthTipsCarousalController extends ChangeNotifier{

  int carousalIndex = 0;

  void changeIndex(int value){
    carousalIndex = value;
    notifyListeners();
  }

}