import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'general_reminder_model.g.dart';

@HiveType(typeId: 4)
class GeneralReminderModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  List<Uint8List>? attachmentList;

  @HiveField(4)
  final DateTime startDate;

  @HiveField(5)
  final GeneralReminderPattern pattern;

  GeneralReminderModel({
    required this.id,
    required this.title,
    this.description,
    this.attachmentList,
    required this.startDate,
    required this.pattern,
  });
}

@HiveType(typeId: 5)
class GeneralReminderPattern {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String pattern;

  @HiveField(2)
  List<String>? daysOfWeek;

  @HiveField(3)
  int? intervalDays;

  GeneralReminderPattern({required this.id, required this.pattern, this.daysOfWeek, this.intervalDays});
}
