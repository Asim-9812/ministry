// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_reminder_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineReminderModelAdapter extends TypeAdapter<MedicineReminderModel> {
  @override
  final int typeId = 6;

  @override
  MedicineReminderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MedicineReminderModel(
      id: fields[0] as int,
      medicineName: fields[1] as String,
      route: fields[2] as MedicineRoute,
      strength: fields[3] as double,
      unit: fields[4] as MedicineUnit,
      frequency: fields[5] as Frequency,
      scheduledTime: (fields[6] as List).cast<DateTime>(),
      totalDays: fields[7] as int,
      startDate: fields[8] as DateTime,
      endDate: fields[9] as DateTime,
      dateList: (fields[10] as List).cast<DateTime>(),
      meal: fields[11] as Meal,
      reminderPattern: fields[12] as ReminderPattern,
      attachment: fields[13] as Uint8List?,
      note: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MedicineReminderModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.medicineName)
      ..writeByte(2)
      ..write(obj.route)
      ..writeByte(3)
      ..write(obj.strength)
      ..writeByte(4)
      ..write(obj.unit)
      ..writeByte(5)
      ..write(obj.frequency)
      ..writeByte(6)
      ..write(obj.scheduledTime)
      ..writeByte(7)
      ..write(obj.totalDays)
      ..writeByte(8)
      ..write(obj.startDate)
      ..writeByte(9)
      ..write(obj.endDate)
      ..writeByte(10)
      ..write(obj.dateList)
      ..writeByte(11)
      ..write(obj.meal)
      ..writeByte(12)
      ..write(obj.reminderPattern)
      ..writeByte(13)
      ..write(obj.attachment)
      ..writeByte(14)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineReminderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MedicineRouteAdapter extends TypeAdapter<MedicineRoute> {
  @override
  final int typeId = 7;

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

class MedicineUnitAdapter extends TypeAdapter<MedicineUnit> {
  @override
  final int typeId = 8;

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

class FrequencyAdapter extends TypeAdapter<Frequency> {
  @override
  final int typeId = 9;

  @override
  Frequency read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Frequency(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Frequency obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
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

class MealAdapter extends TypeAdapter<Meal> {
  @override
  final int typeId = 10;

  @override
  Meal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meal(
      id: fields[0] as int,
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Meal obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
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

class ReminderPatternAdapter extends TypeAdapter<ReminderPattern> {
  @override
  final int typeId = 11;

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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicineReminderModel _$MedicineReminderModelFromJson(
        Map<String, dynamic> json) =>
    MedicineReminderModel(
      id: (json['id'] as num).toInt(),
      medicineName: json['medicineName'] as String,
      route: MedicineRoute.fromJson(json['route'] as Map<String, dynamic>),
      strength: (json['strength'] as num).toDouble(),
      unit: MedicineUnit.fromJson(json['unit'] as Map<String, dynamic>),
      frequency: Frequency.fromJson(json['frequency'] as Map<String, dynamic>),
      scheduledTime: (json['scheduledTime'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      totalDays: (json['totalDays'] as num).toInt(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      dateList: (json['dateList'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      meal: Meal.fromJson(json['meal'] as Map<String, dynamic>),
      reminderPattern: ReminderPattern.fromJson(
          json['reminderPattern'] as Map<String, dynamic>),
      attachment: const Uint8ListBase64Converter()
          .fromJson(json['attachment'] as String?),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$MedicineReminderModelToJson(
        MedicineReminderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'medicineName': instance.medicineName,
      'route': instance.route,
      'strength': instance.strength,
      'unit': instance.unit,
      'frequency': instance.frequency,
      'scheduledTime':
          instance.scheduledTime.map((e) => e.toIso8601String()).toList(),
      'totalDays': instance.totalDays,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'dateList': instance.dateList.map((e) => e.toIso8601String()).toList(),
      'meal': instance.meal,
      'reminderPattern': instance.reminderPattern,
      'attachment':
          const Uint8ListBase64Converter().toJson(instance.attachment),
      'note': instance.note,
    };

MedicineRoute _$MedicineRouteFromJson(Map<String, dynamic> json) =>
    MedicineRoute(
      id: (json['id'] as num).toInt(),
      route: json['route'] as String,
    );

Map<String, dynamic> _$MedicineRouteToJson(MedicineRoute instance) =>
    <String, dynamic>{
      'id': instance.id,
      'route': instance.route,
    };

MedicineUnit _$MedicineUnitFromJson(Map<String, dynamic> json) => MedicineUnit(
      unitId: (json['unitId'] as num).toInt(),
      units: json['units'] as String,
    );

Map<String, dynamic> _$MedicineUnitToJson(MedicineUnit instance) =>
    <String, dynamic>{
      'unitId': instance.unitId,
      'units': instance.units,
    };

Frequency _$FrequencyFromJson(Map<String, dynamic> json) => Frequency(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$FrequencyToJson(Frequency instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$MealToJson(Meal instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ReminderPattern _$ReminderPatternFromJson(Map<String, dynamic> json) =>
    ReminderPattern(
      id: (json['id'] as num).toInt(),
      pattern: json['pattern'] as String,
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      intervalDays: (json['intervalDays'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReminderPatternToJson(ReminderPattern instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pattern': instance.pattern,
      'daysOfWeek': instance.daysOfWeek,
      'intervalDays': instance.intervalDays,
    };
