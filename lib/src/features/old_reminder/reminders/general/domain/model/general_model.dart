import 'dart:typed_data';
import 'package:hive/hive.dart';

import '../../../medicine/domain/model/medicine_model.dart';

part 'general_model.g.dart'; // Generated file

@HiveType(typeId: 40)
class GeneralModel extends HiveObject {
  @HiveField(0)
  final int reminderId;

  @HiveField(1)
  final int reminderTypeId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  String? notes;

  @HiveField(4)
  final bool isReminder;

  @HiveField(5)
  List<Uint8List>? attachment;

  @HiveField(6)
  DateTime? startDate;

  @HiveField(7)
  ReminderPattern? reminderPattern;

  @HiveField(8)
  bool? hasRemindBefore;

  @HiveField(9)
  RemindBefore? remindBefore;

  @HiveField(10)
  final DateTime createdDate;

  GeneralModel({
    required this.reminderId,
    required this.reminderTypeId,
    required this.title,
    this.notes,
    required this.isReminder,
    this.attachment,
    this.startDate,
    this.reminderPattern,
    this.hasRemindBefore,
    this.remindBefore,
    required this.createdDate
  });
}

@HiveType(typeId: 41)
class RemindBefore extends HiveObject {
  @HiveField(0)
  final int remindTypeId;

  @HiveField(1)
  final String remindType;

  @HiveField(2)
  int? remindMeBefore;

  RemindBefore({
    required this.remindTypeId,
    required this.remindType,
    this.remindMeBefore
  });
}
