import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'medicine_reminder_model.g.dart';

@HiveType(typeId: 6)
class MedicineReminderModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String medicineName;

  @HiveField(2)
  final MedicineRoute route;

  @HiveField(3)
  final double strength;

  @HiveField(4)
  final MedicineUnit unit;

  @HiveField(5)
  final Frequency frequency;

  @HiveField(6)
  final List<DateTime> scheduledTime;

  @HiveField(7)
  final int totalDays;

  @HiveField(8)
  final DateTime startDate;

  @HiveField(9)
  final DateTime endDate;

  @HiveField(10)
  final List<DateTime> dateList;

  @HiveField(11)
  final Meal meal;

  @HiveField(12)
  final ReminderPattern reminderPattern;

  @HiveField(13)
  Uint8List? attachment;

  @HiveField(14)
  String? note;

  MedicineReminderModel({
    required this.id,
    required this.medicineName,
    required this.route,
    required this.strength,
    required this.unit,
    required this.frequency,
    required this.scheduledTime,
    required this.totalDays,
    required this.startDate,
    required this.endDate,
    required this.dateList,
    required this.meal,
    required this.reminderPattern,
    this.attachment,
    this.note,
  });
}

@HiveType(typeId: 7)
class MedicineRoute {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  MedicineRoute({required this.id, required this.name});

  factory MedicineRoute.fromJson(Map<String, dynamic> json) {
    return MedicineRoute(
      id: json['id'],
      name: json['route'],
    );
  }

}

@HiveType(typeId: 8)
class MedicineUnit {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  MedicineUnit({required this.id, required this.name});

  factory MedicineUnit.fromJson(Map<String, dynamic> json) {
    return MedicineUnit(
      id: json['unitId'],
      name: json['units'],
    );
  }

}

@HiveType(typeId: 9)
class Frequency {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  Frequency({required this.id, required this.name});
}

@HiveType(typeId: 10)
class Meal {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  Meal({required this.id, required this.name});
}

@HiveType(typeId: 11)
class ReminderPattern {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String pattern;

  @HiveField(2)
  List<String>? daysOfWeek;

  @HiveField(3)
  int? intervalDays;

  ReminderPattern({required this.id, required this.pattern, this.daysOfWeek, this.intervalDays});
}