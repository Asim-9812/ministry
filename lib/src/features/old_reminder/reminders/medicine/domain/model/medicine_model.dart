import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'medicine_model.g.dart'; // Generated file

@HiveType(typeId: 30)
class MedicineModel extends HiveObject {
  @HiveField(0)
  int reminderId;

  @HiveField(1)
  int reminderTypeId;

  @HiveField(2)
  String medicineName;

  @HiveField(3)
  MedicineRoute route;

  @HiveField(4)
  double strength;

  @HiveField(5)
  MedicineUnit unit;

  @HiveField(6)
  Frequency frequency;

  @HiveField(7)
  List<DateTime> scheduleTime;

  @HiveField(8)
  int totalDays;

  @HiveField(9)
  DateTime startDate;

  @HiveField(10)
  DateTime endDate;

  @HiveField(11)
  Meal meal;

  @HiveField(12)
  ReminderPattern reminderPattern;

  @HiveField(13)
  Uint8List? attachment;

  @HiveField(14)
  String? note;

  @HiveField(15)
  List<int> notificationIds;

  @HiveField(16)
  List<DateTime> dateList;

  MedicineModel({
    required this.frequency,
    required this.strength,
    required this.route,
    required this.reminderPattern,
    required this.reminderId,
    required this.reminderTypeId,
    required this.medicineName,
    required this.meal,
    required this.unit,
    required this.scheduleTime,
    required this.startDate,
    required this.endDate,
    required this.notificationIds,
    required this.totalDays,
    required this.dateList,
    this.note,
    this.attachment,
  });
}

@HiveType(typeId: 31)
class ReminderPattern extends HiveObject {
  @HiveField(0)
  int patternId;

  @HiveField(1)
  String patternName;

  @HiveField(2)
  List<String>? daysOfWeek;

  @HiveField(3)
  int? daysOfInterval;

  ReminderPattern({
    required this.patternId,
    required this.patternName,
    this.daysOfWeek,
    this.daysOfInterval,
  });
}

@HiveType(typeId: 32)
class Meal extends HiveObject {
  @HiveField(0)
  int mealId;

  @HiveField(1)
  String mealTime;

  Meal({
    required this.mealId,
    required this.mealTime,
  });
}

@HiveType(typeId: 33)
class Frequency extends HiveObject {
  @HiveField(0)
  int frequencyId;

  @HiveField(1)
  String frequency;

  Frequency({
    required this.frequency,
    required this.frequencyId,
  });
}

@HiveType(typeId: 34)
class MedicineUnit extends HiveObject {
  @HiveField(0)
  int unitId;

  @HiveField(1)
  String units;

  MedicineUnit({
    required this.unitId,
    required this.units,
  });

  factory MedicineUnit.fromJson(Map<String, dynamic> json) {
    return MedicineUnit(
      unitId: json['unitId'],
      units: json['units'],
    );
  }
}

@HiveType(typeId: 35)
class MedicineRoute extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  String route;

  MedicineRoute({
    required this.id,
    required this.route,
  });

  factory MedicineRoute.fromJson(Map<String, dynamic> json) {
    return MedicineRoute(
      id: json['id'],
      route: json['route'],
    );
  }
}
