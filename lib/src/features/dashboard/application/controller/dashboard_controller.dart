


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final dashboardController = ChangeNotifierProvider((ref)=>DashboardController());


class DashboardController extends ChangeNotifier{

  int pageIndex = 2;
  int navIndex = -1;

  PageController pageController = PageController(initialPage: 2);

  void changePageIndex(int value){
    pageIndex = value;
    pageController.jumpToPage(pageIndex);
    notifyListeners();
  }

  void changeNavIndex(int value){
    navIndex = value;
    notifyListeners();
  }


}