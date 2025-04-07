



import '../../medicine/domain/model/medicine_model.dart';
import '../domain/model/general_model.dart';

List<ReminderPattern> generalPatternList = [
  ReminderPattern(patternId: 1, patternName: 'Once'),
  ReminderPattern(patternId: 2, patternName: 'Everyday'),
  ReminderPattern(patternId: 3, patternName: 'Specific Days'),
  ReminderPattern(patternId: 4, patternName: 'Intervals'),
];

List<RemindBefore> remindBeforeList = [
  RemindBefore(remindTypeId: 1, remindType: 'Days'),
  RemindBefore(remindTypeId: 2, remindType: 'Hrs'),
  RemindBefore(remindTypeId: 3, remindType: 'Minutes'),
];
