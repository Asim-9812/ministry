





import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ministry/src/features/old_reminder/reminders/medicine/domain/model/medicine_model.dart';

final reminderController = ChangeNotifierProvider.autoDispose((ref)=> ReminderController());


class ReminderController extends ChangeNotifier{

  int? reminderType;

  void changeReminderType(int? val){
    reminderType = val;
    notifyListeners();
  }

}