// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GeneralModelAdapter extends TypeAdapter<GeneralModel> {
  @override
  final int typeId = 40;

  @override
  GeneralModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneralModel(
      reminderId: fields[0] as int,
      reminderTypeId: fields[1] as int,
      title: fields[2] as String,
      notes: fields[3] as String?,
      isReminder: fields[4] as bool,
      attachment: (fields[5] as List?)?.cast<Uint8List>(),
      startDate: fields[6] as DateTime?,
      reminderPattern: fields[7] as ReminderPattern?,
      hasRemindBefore: fields[8] as bool?,
      remindBefore: fields[9] as RemindBefore?,
      createdDate: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GeneralModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.reminderId)
      ..writeByte(1)
      ..write(obj.reminderTypeId)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.notes)
      ..writeByte(4)
      ..write(obj.isReminder)
      ..writeByte(5)
      ..write(obj.attachment)
      ..writeByte(6)
      ..write(obj.startDate)
      ..writeByte(7)
      ..write(obj.reminderPattern)
      ..writeByte(8)
      ..write(obj.hasRemindBefore)
      ..writeByte(9)
      ..write(obj.remindBefore)
      ..writeByte(10)
      ..write(obj.createdDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GeneralModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RemindBeforeAdapter extends TypeAdapter<RemindBefore> {
  @override
  final int typeId = 41;

  @override
  RemindBefore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RemindBefore(
      remindTypeId: fields[0] as int,
      remindType: fields[1] as String,
      remindMeBefore: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RemindBefore obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.remindTypeId)
      ..writeByte(1)
      ..write(obj.remindType)
      ..writeByte(2)
      ..write(obj.remindMeBefore);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemindBeforeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
