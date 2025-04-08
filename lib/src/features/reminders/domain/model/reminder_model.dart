import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import 'general_reminder_model.dart';
import 'medicine_reminder_model.dart';
import 'notes_model.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class ReminderModel extends HiveObject {
  @HiveField(0)
  final int reminderId;

  @HiveField(1)
  final int reminderType; // 1 = medicine, 2 = general, 3 = notes

  @HiveField(2)
  final MedicineReminderModel? medicineReminder;

  @HiveField(3)
  final GeneralReminderModel? generalReminder;

  @HiveField(4)
  final NoteModel? notes;

  ReminderModel({
    required this.reminderId,
    required this.reminderType,
    this.generalReminder,
    this.medicineReminder,
    this.notes,
  });

  factory ReminderModel.fromJson(Map<String, dynamic> json) =>
      _$ReminderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderModelToJson(this);
}
