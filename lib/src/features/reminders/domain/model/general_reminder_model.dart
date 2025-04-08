import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/controllers/uint8ListBase64Converter.dart';
part 'general_reminder_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class GeneralReminderModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  @Uint8ListListBase64Converter()
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

  factory GeneralReminderModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralReminderModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralReminderModelToJson(this);
}

@HiveType(typeId: 5)
@JsonSerializable()
class GeneralReminderPattern {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String pattern;

  @HiveField(2)
  List<String>? daysOfWeek;

  @HiveField(3)
  int? intervalDays;

  GeneralReminderPattern({
    required this.id,
    required this.pattern,
    this.daysOfWeek,
    this.intervalDays,
  });

  factory GeneralReminderPattern.fromJson(Map<String, dynamic> json) =>
      _$GeneralReminderPatternFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralReminderPatternToJson(this);
}
