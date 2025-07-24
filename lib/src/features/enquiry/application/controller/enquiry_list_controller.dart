



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final enquiryListController = ChangeNotifierProvider.autoDispose((ref)=>EnquiryListController());

class EnquiryListController extends ChangeNotifier{

  int filter = 0;


  void changeFilter(int val){
    filter = val;
    notifyListeners();

  }


}