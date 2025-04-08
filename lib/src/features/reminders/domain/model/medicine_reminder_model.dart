import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/controllers/uint8ListBase64Converter.dart';

part 'medicine_reminder_model.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
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
  @Uint8ListBase64Converter()
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

  factory MedicineReminderModel.fromJson(Map<String, dynamic> json) =>
      _$MedicineReminderModelFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineReminderModelToJson(this);
}

@HiveType(typeId: 7)
@JsonSerializable()
class MedicineRoute {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String route;

  MedicineRoute({required this.id, required this.route});

  factory MedicineRoute.fromJson(Map<String, dynamic> json) =>
      _$MedicineRouteFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineRouteToJson(this);
}

@HiveType(typeId: 8)
@JsonSerializable()
class MedicineUnit {
  @HiveField(0)
  final int unitId;

  @HiveField(1)
  final String units;

  MedicineUnit({required this.unitId, required this.units});

  factory MedicineUnit.fromJson(Map<String, dynamic> json) =>
      _$MedicineUnitFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineUnitToJson(this);
}

@HiveType(typeId: 9)
@JsonSerializable()
class Frequency {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  Frequency({required this.id, required this.name});

  factory Frequency.fromJson(Map<String, dynamic> json) =>
      _$FrequencyFromJson(json);

  Map<String, dynamic> toJson() => _$FrequencyToJson(this);
}

@HiveType(typeId: 10)
@JsonSerializable()
class Meal {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  Meal({required this.id, required this.name});

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);
}

@HiveType(typeId: 11)
@JsonSerializable()
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

  factory ReminderPattern.fromJson(Map<String, dynamic> json) =>
      _$ReminderPatternFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderPatternToJson(this);
}
