

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addMedicineController = ChangeNotifierProvider((ref)=> AddMedicineController());


class AddMedicineController extends ChangeNotifier{

  final formKey = GlobalKey<FormState>();
  int? reminderId;
  TextEditingController medName = TextEditingController();
  TextEditingController strengthController = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController medDuration = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController interval = TextEditingController();
  TextEditingController notes = TextEditingController();
  int mealId = 1;
  int routeId = 0;
  bool routeError = false;
  int frequencyId = 0;
  String? frequencyError;
  int patternId = 0;
  String? patternError;
  int unitId = 0;
  bool unitError = false;
  List<DateTime> scheduledTimeList = [];
  List<String> selectedDaysOfWeek = [];


  void changeReminderId(int val){
    reminderId = val;
    notifyListeners();
  }


  void changeMealType(int val){
    mealId = val;
    notifyListeners();
  }

  void changeRouteType(int val){
    routeId = val;
    notifyListeners();
  }

  void changeUnit(int val){
    unitId = val;
    notifyListeners();
  }

  void changeFrequency(int val){
    frequencyId = val;
    notifyListeners();
  }

  void changePattern(int val){
    patternId = val;
    notifyListeners();
  }

  void updateSchedule(int frequencyId, DateTime scheduleTime) {
    if(frequencyId == 0){
     scheduledTimeList = [];
    }
    else if (frequencyId == 1) {
      // Once a day
      scheduledTimeList = [scheduleTime];
    } else if (frequencyId == 2) {
      // Twice a day (morning & evening)
      scheduledTimeList = [
        scheduleTime,
        scheduleTime.add(Duration(hours: 12)),
      ];
    } else if (frequencyId == 3) {
      // Three times a day (morning, afternoon, evening)
      scheduledTimeList = [
        scheduleTime,
        scheduleTime.add(Duration(hours: 6)),
        scheduleTime.add(Duration(hours: 12)),
      ];
    } else if (frequencyId == 4) {
      // Four times a day (morning, noon, evening, night)
      scheduledTimeList = [
        scheduleTime,
        scheduleTime.add(Duration(hours: 6)),
        scheduleTime.add(Duration(hours: 12)),
        scheduleTime.add(Duration(hours: 18)),
      ];
    }

    print(scheduledTimeList);
    notifyListeners();
  }

  void updateDaysList(String day) {
    if(selectedDaysOfWeek.contains(day)){
      selectedDaysOfWeek.remove(day);
    }
    else{
      selectedDaysOfWeek.add(day);
    }
    notifyListeners();
  }


  void routeHasError(bool value){
    routeError = value;
    notifyListeners();
  }

  void unitHasError(bool value){
    unitError = value;
    notifyListeners();
  }

  void frequencyHasError(String? value){
    frequencyError = value;
    notifyListeners();
  }

  void patternHasError(String? value){
    patternError = value;
    notifyListeners();
  }



}