

import 'package:hive/hive.dart';
import 'general_reminder_model.dart';
import 'medicine_reminder_model.dart';
import 'notes_model.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 2)
class ReminderModel extends HiveObject {
  @HiveField(0)
  final int reminderId;

  @HiveField(1)
  final int reminderType;    //med = 1  //gen = 2  //notes = 3

  @HiveField(2)
  MedicineReminderModel? medicineReminder;  // type 1

  @HiveField(3)
  GeneralReminderModel? generalReminder; // type 2

  @HiveField(4)
  NoteModel? notes; // type 3

  ReminderModel({
    required this.reminderId,
    required this.reminderType,
    this.generalReminder,
    this.medicineReminder,
    this.notes,
  });
}