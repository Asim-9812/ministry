// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeneralReminderModelAdapter extends TypeAdapter<GeneralReminderModel> {
  @override
  final int typeId = 4;

  @override
  GeneralReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneralReminderModel(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String?,
      attachmentList: (fields[3] as List?)?.cast<Uint8List>(),
      startDate: fields[4] as DateTime,
      pattern: fields[5] as ReminderPattern,
    );
  }

  @override
  void write(BinaryWriter writer, GeneralReminderModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.attachmentList)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.pattern);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneralReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReminderPatternAdapter extends TypeAdapter<ReminderPattern> {
  @override
  final int typeId = 5;

  @override
  ReminderPattern read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderPattern(
      id: fields[0] as int,
      pattern: fields[1] as String,
      daysOfWeek: (fields[2] as List?)?.cast<String>(),
      intervalDays: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderPattern obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pattern)
      ..writeByte(2)
      ..write(obj.daysOfWeek)
      ..writeByte(3)
      ..write(obj.intervalDays);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderPatternAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
