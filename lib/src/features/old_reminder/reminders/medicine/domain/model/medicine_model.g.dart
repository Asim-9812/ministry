// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineModelAdapter extends TypeAdapter<MedicineModel> {
  @override
  final int typeId = 30;

  @override
  MedicineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicineModel(
      frequency: fields[6] as Frequency,
      strength: fields[4] as double,
      route: fields[3] as MedicineRoute,
      reminderPattern: fields[12] as ReminderPattern,
      reminderId: fields[0] as int,
      reminderTypeId: fields[1] as int,
      medicineName: fields[2] as String,
      meal: fields[11] as Meal,
      unit: fields[5] as MedicineUnit,
      scheduleTime: (fields[7] as List).cast<DateTime>(),
      startDate: fields[9] as DateTime,
      endDate: fields[10] as DateTime,
      notificationIds: (fields[15] as List).cast<int>(),
      totalDays: fields[8] as int,
      dateList: (fields[16] as List).cast<DateTime>(),
      note: fields[14] as String?,
      attachment: fields[13] as Uint8List?,
    );
  }

  @override
  void write(BinaryWriter writer, MedicineModel obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.reminderId)
      ..writeByte(1)
      ..write(obj.reminderTypeId)
      ..writeByte(2)
      ..write(obj.medicineName)
      ..writeByte(3)
      ..write(obj.route)
      ..writeByte(4)
      ..write(obj.strength)
      ..writeByte(5)
      ..write(obj.unit)
      ..writeByte(6)
      ..write(obj.frequency)
      ..writeByte(7)
      ..write(obj.scheduleTime)
      ..writeByte(8)
      ..write(obj.totalDays)
      ..writeByte(9)
      ..write(obj.startDate)
      ..writeByte(10)
      ..write(obj.endDate)
      ..writeByte(11)
      ..write(obj.meal)
      ..writeByte(12)
      ..write(obj.reminderPattern)
      ..writeByte(13)
      ..write(obj.attachment)
      ..writeByte(14)
      ..write(obj.note)
      ..writeByte(15)
      ..write(obj.notificationIds)
      ..writeByte(16)
      ..write(obj.dateList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReminderPatternAdapter extends TypeAdapter<ReminderPattern> {
  @override
  final int typeId = 31;

  @override
  ReminderPattern read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderPattern(
      patternId: fields[0] as int,
      patternName: fields[1] as String,
      daysOfWeek: (fields[2] as List?)?.cast<String>(),
      daysOfInterval: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderPattern obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.patternId)
      ..writeByte(1)
      ..write(obj.patternName)
      ..writeByte(2)
      ..write(obj.daysOfWeek)
      ..writeByte(3)
      ..write(obj.daysOfInterval);
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

class MealAdapter extends TypeAdapter<Meal> {
  @override
  final int typeId = 32;

  @override
  Meal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meal(
      mealId: fields[0] as int,
      mealTime: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Meal obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.mealId)
      ..writeByte(1)
      ..write(obj.mealTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FrequencyAdapter extends TypeAdapter<Frequency> {
  @override
  final int typeId = 33;

  @override
  Frequency read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Frequency(
      frequency: fields[1] as String,
      frequencyId: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Frequency obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.frequencyId)
      ..writeByte(1)
      ..write(obj.frequency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrequencyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MedicineUnitAdapter extends TypeAdapter<MedicineUnit> {
  @override
  final int typeId = 34;

  @override
  MedicineUnit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicineUnit(
      unitId: fields[0] as int,
      units: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MedicineUnit obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.unitId)
      ..writeByte(1)
      ..write(obj.units);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineUnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MedicineRouteAdapter extends TypeAdapter<MedicineRoute> {
  @override
  final int typeId = 35;

  @override
  MedicineRoute read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicineRoute(
      id: fields[0] as int,
      route: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MedicineRoute obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.route);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineRouteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
