


import '../domain/model/medicine_model.dart';

List<Frequency> frequencyList = [
  Frequency(frequency: 'OD - Once a day', frequencyId: 1),
  Frequency(frequency: 'BD - Twice a day', frequencyId: 2),
  Frequency(frequency: 'TD - Thrice a day', frequencyId: 3),
  Frequency(frequency: 'QDS - Four times a day', frequencyId: 4),
];


List<ReminderPattern> patternList = [
  ReminderPattern(patternId: 1, patternName: 'Everyday'),
  ReminderPattern(patternId: 2, patternName: 'Specific Days'),
  ReminderPattern(patternId: 3, patternName: 'Intervals'),
];


List<String> daysOfWeek = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];