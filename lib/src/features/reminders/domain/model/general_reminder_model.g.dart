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
      startDate: fields[3] as DateTime,
      pattern: fields[4] as GeneralReminderPattern,
    );
  }

  @override
  void write(BinaryWriter writer, GeneralReminderModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.startDate)
      ..writeByte(4)
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

class GeneralReminderPatternAdapter
    extends TypeAdapter<GeneralReminderPattern> {
  @override
  final int typeId = 5;

  @override
  GeneralReminderPattern read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GeneralReminderPattern(
      id: fields[0] as int,
      pattern: fields[1] as String,
      daysOfWeek: (fields[2] as List?)?.cast<String>(),
      intervalDays: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, GeneralReminderPattern obj) {
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
      other is GeneralReminderPatternAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralReminderModel _$GeneralReminderModelFromJson(
        Map<String, dynamic> json) =>
    GeneralReminderModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      startDate: DateTime.parse(json['startDate'] as String),
      pattern: GeneralReminderPattern.fromJson(
          json['pattern'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeneralReminderModelToJson(
        GeneralReminderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'pattern': instance.pattern,
    };

GeneralReminderPattern _$GeneralReminderPatternFromJson(
        Map<String, dynamic> json) =>
    GeneralReminderPattern(
      id: (json['id'] as num).toInt(),
      pattern: json['pattern'] as String,
      daysOfWeek: (json['daysOfWeek'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      intervalDays: (json['intervalDays'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GeneralReminderPatternToJson(
        GeneralReminderPattern instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pattern': instance.pattern,
      'daysOfWeek': instance.daysOfWeek,
      'intervalDays': instance.intervalDays,
    };
