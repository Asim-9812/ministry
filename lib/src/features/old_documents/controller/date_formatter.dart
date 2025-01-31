


import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = _formatDate(newValue.text);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _formatDate(String input) {
    // Remove any non-numeric characters
    final cleanInput = input.replaceAll(RegExp(r'[^0-9]'), '');

    // Apply 'yyyy-MM-dd' format
    final buffer = StringBuffer();
    for (var i = 0; i < cleanInput.length; i++) {
      if (i == 4 || i == 6) {
        buffer.write('-');
      }
      buffer.write(cleanInput[i]);
    }

    return buffer.toString();
  }
}


String calculateAge(String newAge) {
  final now = DateTime.now();
  final dob = DateFormat('yyyy-MM-dd').parse(newAge);
  final year = now.year - dob.year ;
  String age = '';

  if(year <= 1){
    final month = now.month - dob.month ;
    if(month == 0){
      final days = now.day - dob.day ;
      if(days == 0){
        int ageDifference = now.difference(dob).inHours;
        age = '${ageDifference}Hrs';

        return age;

      }
      else {
        Duration ageDuration = DateTime.now().difference(dob);

        int ageInDays = ageDuration.inDays;
        int remainingHours = (ageDuration.inHours % 24);

        age = '${ageInDays}D.${remainingHours}H';

        return age;
      }
    }
    else{
      Duration ageDuration = DateTime.now().difference(dob);
      int ageInMonths = (ageDuration.inDays / 30).floor();
      int remainingDays = (ageDuration.inDays % 30).floor();
      age = '${ageInMonths}M.${remainingDays}D';
      return age;
    }

  }else{
    Duration ageDuration = DateTime.now().difference(dob);
    int ageInYears = (ageDuration.inDays / 365).floor();
    int remainingMonths = ((ageDuration.inDays % 365) / 30).floor();
    age = '${ageInYears}Y.${remainingMonths}M';
    return age;

  }
}