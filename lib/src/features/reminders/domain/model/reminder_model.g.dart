// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderModelAdapter extends TypeAdapter<ReminderModel> {
  @override
  final int typeId = 2;

  @override
  ReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderModel(
      reminderId: fields[0] as int,
      reminderType: fields[1] as int,
      generalReminder: fields[3] as GeneralReminderModel?,
      medicineReminder: fields[2] as MedicineReminderModel?,
      notes: fields[4] as NoteModel?,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.reminderId)
      ..writeByte(1)
      ..write(obj.reminderType)
      ..writeByte(2)
      ..write(obj.medicineReminder)
      ..writeByte(3)
      ..write(obj.generalReminder)
      ..writeByte(4)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderModel _$ReminderModelFromJson(Map<String, dynamic> json) =>
    ReminderModel(
      reminderId: (json['reminderId'] as num).toInt(),
      reminderType: (json['reminderType'] as num).toInt(),
      generalReminder: json['generalReminder'] == null
          ? null
          : GeneralReminderModel.fromJson(
              json['generalReminder'] as Map<String, dynamic>),
      medicineReminder: json['medicineReminder'] == null
          ? null
          : MedicineReminderModel.fromJson(
              json['medicineReminder'] as Map<String, dynamic>),
      notes: json['notes'] == null
          ? null
          : NoteModel.fromJson(json['notes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReminderModelToJson(ReminderModel instance) =>
    <String, dynamic>{
      'reminderId': instance.reminderId,
      'reminderType': instance.reminderType,
      'medicineReminder': instance.medicineReminder,
      'generalReminder': instance.generalReminder,
      'notes': instance.notes,
    };
