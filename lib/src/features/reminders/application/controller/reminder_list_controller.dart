





import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reminderController = ChangeNotifierProvider.autoDispose((ref)=> ReminderController());


class ReminderController extends ChangeNotifier{

  int? reminderType;

  void changeReminderType(int? val){
    reminderType = val;
    notifyListeners();
  }

}